unit LMDDocModel;
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

LMDDocModel unit (RS)
-----------------------------------
The base class for all the elements of a document (text blocks, tables, images etc)
in the framework of LMD Document model

Changes
-------
* Not released yet

###############################################################################}

interface

uses
  Math, Classes, SysUtils, Controls, Windows, Printers, Graphics, Types,
  LMDCustomComponent, LMDTypes, LMDPrinter;

type

  TLMDVerticalAlignment = (vaTop, vaBottom);
  TLMDHorizontalAlignment = (haLeft, haCenter, haRight);

  TLMDTextAlignment = (laLeft, laRight, laCenter, laWidth);

  {******************* Object TLMDTextAreaSettings ****************************}
  TLMDTextAreaSettings = class(TPersistent)
  private
    FFont: TFont;
    FAlign: TLMDTextAlignment;
    FReflowText: boolean;
    FIsRTF: boolean;
    FTabSize: Integer;
    procedure SetFont(const Value: TFont);
    procedure SetIsRTF(const Value: boolean);
    procedure SetTabSize(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property TabSize: Integer read FTabSize write SetTabSize default 8;
    property IsRTF: boolean read FIsRTF write SetIsRTF default false;
    property Font: TFont read FFont write SetFont;
    property Align: TLMDTextAlignment read FAlign write FAlign default laLeft;
    property ReflowText: boolean read FReflowText write FReflowText default false;
  end;

  TLMDDocEntity = class(TPersistent)
  private
    FTag: TObject;
  public
    property Tag: TObject read FTag write FTag;
  end;

  TLMDDocContainer = class(TLMDDocEntity)
  protected
    FChildElements: TList;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ChildElements: TList read FChildElements;
  end;

  TLMDDocument = class(TLMDDocContainer)
  end;

  TLMDDocElement = class(TLMDDocContainer)
  private
    FHeight: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FTop: Integer;

    FCanGrow: boolean;
    FAutoSize: boolean;
    FPageNum: integer;
  public
    constructor Create;

    procedure PrepareForPrinting(APageCanvas: TCanvas;
                                 AMargins: TLMDMargins); virtual;
  published
    //sizes are in PIXELS
    property Top: Integer read FTop write FTop default 0;
    property Left: Integer read FLeft write FLeft default 0;
    property Height: Integer read FHeight write FHeight default 0;
    property Width: Integer read FWidth write FWidth default 0;
    property PageNum: Integer read FPageNum write FPageNum default 0;
    property AutoSize: boolean read FAutoSize write FAutoSize default true;
    property CanGrow: boolean read FCanGrow write FCanGrow default true;
  end;

  TLMDVertPlaceholder = class (TLMDDocElement)
  end;

  TLMDTextBlock = class (TLMDDocElement)
  private
    FStrings: TLMDStrings;

    FTextFormat: TLMDTextAreaSettings;
    FIsRTF: Boolean;
    FEndPos: Integer;
    FStartPos: Integer;

    procedure SetTextFormat(const Value: TLMDTextAreaSettings);
    procedure SetIsRTF(const Value: boolean);
    procedure SetStrings(const Value: TLMDStrings);
  public
    constructor Create; 
    destructor Destroy; override;
  published
    property Strings: TLMDStrings read FStrings write SetStrings;
    property TextFormat: TLMDTextAreaSettings read FTextFormat write SetTextFormat;
    property IsRTF: boolean read FIsRTF write SetIsRTF default false;
    property StartPos: integer read FStartPos write FStartPos default -1;
    property EndPos: integer read FEndPos write FEndPos default 0;
  end;

  TLMDDocImage = class (TLMDDocElement)
  private
    FPicture: TBitmap;
    FRect: TRect;
    procedure SetPicture(const Value: TBitmap);
    procedure SetRect(const Value: TRect);
  public
    constructor Create;

    property Picture: TBitmap read FPicture write SetPicture;
    property PictureRect: TRect read FRect write SetRect;
  end;

 {******************* Object TLMDTableCellFormat *****************************}
  TLMDTableCellFormat = class (TPersistent)
  private
    FTopBorderPen: TPen;
    FBottomBorderPen: TPen;
    FRightBorderPen: TPen;
    FLeftBorderPen: TPen;
    FTextFormat: TLMDTextAreaSettings;
    FMargins: TLMDMargins;
    FIsRTF: boolean;
    procedure SetBottomBorderPen(const Value: TPen);
    procedure SetLeftBorderPen(const Value: TPen);
    procedure SetRightBorderPen(const Value: TPen);
    procedure SetTopBorderPen(const Value: TPen);
    procedure SetTextFormat(const Value: TLMDTextAreaSettings);
    procedure SetMargins(const Value: TLMDMargins);
    procedure SetIsRTF(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property LeftBorderPen: TPen read FLeftBorderPen write SetLeftBorderPen;
    property RightBorderPen: TPen read FRightBorderPen write SetRightBorderPen;
    property TopBorderPen: TPen read FTopBorderPen write SetTopBorderPen;
    property BottomBorderPen: TPen read FBottomBorderPen write SetBottomBorderPen;
    property TextFormat: TLMDTextAreaSettings read FTextFormat write SetTextFormat;
    property IsRTF: boolean read FIsRTF write SetIsRTF default false;
    property Margins: TLMDMargins read FMargins write SetMargins;
  end;

  {******************* Object TLMDTableColumn *********************************}
  TLMDTableColumn = class(TPersistent)
  private
    FWidth: Integer;
  public
    constructor Create;
  published
    property Width: Integer read FWidth write FWidth default 0;
  end;

  TLMDDocTable = class;
  {******************* Object TLMDTableCell ***********************************}
  TLMDTableCell = class(TPersistent)
  private
    FCellFormat: TLMDTableCellFormat;
    FStrings: TLMDStrings;
    FHasSpecialFormat: boolean;
    procedure SetCellFormat(const Value: TLMDTableCellFormat);
    procedure SetHasSpecialFormat(const Value: boolean);
    procedure SetStrings(const Value: TLMDStrings);
  protected
    FTable: TLMDDocTable;
  public
    constructor Create;
    destructor Destroy; override;

    property CellFormat: TLMDTableCellFormat read FCellFormat write SetCellFormat;
    property HasSpecialFormat: boolean read FHasSpecialFormat write SetHasSpecialFormat default false;
    property Strings: TLMDStrings read FStrings write SetStrings;
  end;

  TLMDCellsMatrix = array of array of TLMDTableCell;
  TLMDColumnsWidthMode = (cwmEqual, cwmAutoSize, cwmManual);
  {******************* Object TLMDDocTable ************************************}
  TLMDDocTable = class (TLMDDocElement)
  private
    FCells: TLMDCellsMatrix;
    FDefaultCellFormat: TLMDTableCellFormat;
    FColumns: array of TLMDTableColumn;
    FRowCount: integer;
    FArea: TRect;
    FFirstYOffset: integer;
    FColumnsWidthMode: TLMDColumnsWidthMode;
    FColCount: integer;
    procedure SetDefaultCellFormat(const Value: TLMDTableCellFormat);
    procedure SetRowCount(const Value: integer);
    function GetCell(ARow, ACol: integer): TLMDTableCell;
    procedure SetColCount(const Value: integer);
    function GetColumn(ACol: integer): TLMDTableColumn;
  protected
    FCellFormats: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PrepareForPrinting(APageCanvas: TCanvas;
                                 AMargins: TLMDMargins); override;
    function GetHorizontalCellOffset(ARow, ACol: integer): Integer;

    property Cell [ARow: integer; ACol: integer]: TLMDTableCell read GetCell;
    property Columns[ACol: integer]: TLMDTableColumn read GetColumn;

    property DefaultCellFormat: TLMDTableCellFormat read FDefaultCellFormat write SetDefaultCellFormat;
    property ColumnsWidthMode: TLMDColumnsWidthMode read FColumnsWidthMode write FColumnsWidthMode;
    property RowCount: integer read FRowCount write SetRowCount default 0;
    property ColCount: integer read FColCount write SetColCount default 0;
    property Area: TRect read FArea write FArea;
    property FirstYOffset: integer read FFirstYOffset write FFirstYOffset default 0;
  end;

implementation
uses LMDStrings, LMDPrintConst;

{******************* Object TLMDTableCellFormat *******************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTableCellFormat.SetBottomBorderPen(const Value: TPen);
begin
  FBottomBorderPen.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDTableCellFormat.SetLeftBorderPen(const Value: TPen);
begin
  FLeftBorderPen.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDTableCellFormat.SetRightBorderPen(const Value: TPen);
begin
  FRightBorderPen.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDTableCellFormat.SetTextFormat(const Value: TLMDTextAreaSettings);
begin
  FTextFormat.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDTableCellFormat.SetTopBorderPen(const Value: TPen);
begin
  FTopBorderPen.Assign(Value);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDTableCellFormat.Create;
begin
  inherited;

  Self.FMargins := TLMDMargins.Create;

  Self.FMargins.Top := 1;
  Self.FMargins.Left := 1;
  Self.FMargins.Right := 1;
  Self.FMargins.Bottom := 1;

  Self.FTopBorderPen := TPen.Create;
  Self.FLeftBorderPen := TPen.Create;
  Self.FRightBorderPen := TPen.Create;
  Self.FBottomBorderPen := TPen.Create;
  Self.FTextFormat := TLMDTextAreaSettings.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDTableCellFormat.Destroy;
begin
  Self.FMargins.Free;
  Self.FTopBorderPen.Free;
  Self.FLeftBorderPen.Free;
  Self.FRightBorderPen.Free;
  Self.FBottomBorderPen.Free;
  Self.FTextFormat.Free;
  inherited;
end;

{********************* Object TLMDTableColumn *********************************}
{----------------------- public -----------------------------------------------}
constructor TLMDTableColumn.Create;
begin
  inherited;

  FWidth := 0;
end;

{******************* Object TLMDDocTable **************************************}
{----------------------- private ----------------------------------------------}
{procedure TLMDDocTable.SetCells(const Value: TLMDCellsMatrix);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDDocTable.SetRowCount(const Value: integer);
var
  i, j: integer;
begin
  if Value > Self.FRowCount then
  begin
    SetLength(Self.FCells, Value);
    for i := FRowCount to Value - 1 do
    begin
      SetLength(Self.FCells[i], Length(Self.FColumns));
      for j := 0 to Length(Self.FColumns) - 1 do
        Self.FCells[i, j] := TLMDTableCell.Create;
    end;
  end
  else
  begin
    for i := FRowCount - 1 downto Value do
    begin
      for j := 0 to Length(Self.FColumns) - 1 do
        Self.FCells[i, j].Free;
      Finalize(Self.FCells[i]);
      end;
    SetLength(Self.FCells, Value);
  end;
  FRowCount := Value;
end;

{------------------------------------------------------------------------------}
function TLMDDocTable.GetCell(ARow, ACol: integer): TLMDTableCell;
begin
  result := Self.FCells[ARow, ACol];
end;

{----------------------- public -----------------------------------------------}
constructor TLMDDocTable.Create;
begin
  inherited;
  Self.FCellFormats := TList.Create;
  Self.FDefaultCellFormat := TLMDTableCellFormat.Create;

  FRowCount := 0;
  FColCount := 0;

  FFirstYOffset := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDDocTable.Destroy;
var
  i, j: integer;
begin
  Self.FCellFormats.Free;
  for i := 0 to Length(Self.FCells) - 1 do
  begin
    for j := 0 to Length(Self.FCells[i]) - 1 do
      Self.FCells[i, j].Free;
    Finalize(Self.FCells[i]);
    end;
  Finalize(Self.FCells);
  for j := 0 to Length(Self.FColumns) - 1 do
    Self.FColumns[j].Free;
 Finalize(Self.FColumns);
 Self.FDefaultCellFormat.Free;
  inherited;
end;

{******************* Object TLMDTableCell *************************************}
{----------------------- private ----------------------------------------------}
constructor TLMDTableCell.Create;
begin
  inherited;

  Self.FStrings := TLMDMemoryStrings.Create;
  Self.FCellFormat := TLMDTableCellFormat.Create;

  FHasSpecialFormat := false;
end;

destructor TLMDTableCell.Destroy;
begin
  Self.FStrings.Free;
  Self.FCellFormat.Free;
  inherited;
end;

procedure TLMDTableCell.SetCellFormat(const Value: TLMDTableCellFormat);
begin
  FCellFormat.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDDocTable.SetDefaultCellFormat(const Value: TLMDTableCellFormat);
begin
  FDefaultCellFormat.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDTableCell.SetHasSpecialFormat(const Value: boolean);
begin
  FHasSpecialFormat := Value;
end;

{ TLMDTextBlock }

constructor TLMDTextBlock.Create;
begin
  inherited;

  FTextFormat := TLMDTextAreaSettings.Create;

  FIsRTF := false;
  FEndPos := 0;
  FStartPos := -1;

  FStrings := TLMDMemoryStrings.Create;
end;

destructor TLMDTextBlock.Destroy;
begin
  FTextFormat.Free;
  FStrings.Free;

  inherited;
end;

procedure TLMDTextBlock.SetIsRTF(const Value: boolean);
begin
  FIsRTF := Value;
end;

procedure TLMDTextBlock.SetStrings(const Value: TLMDStrings);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument);

  FStrings.Assign(Value);
end;

procedure TLMDTextBlock.SetTextFormat(const Value: TLMDTextAreaSettings);
begin
  FTextFormat.Assign(Value);
end;

procedure TLMDTableCellFormat.SetMargins(const Value: TLMDMargins);
begin
  FMargins.Assign(Value);
end;

function TLMDDocTable.GetHorizontalCellOffset(ARow,
  ACol: integer): Integer;
var
  i: integer;
begin
  Result := Self.Left;
  for i := 0 to ACol - 1 do
    Result := Result + Self.Columns[i].Width;
end;

procedure TLMDDocTable.SetColCount(const Value: integer);
var
  col, row: integer;
begin
  if Value > FColCount then
  begin
    SetLength(Self.FColumns, Value);
    for col := FColCount to Value - 1 do
      Self.FColumns[col] := TLMDTableColumn.Create;
    for row := 0 to Self.FRowCount - 1 do
    begin
      SetLength(Self.FCells[row], Value);
      for col := FColCount to Value - 1 do
        Self.FCells[row, col] := TLMDTableCell.Create;
    end;
  end
  else if Value < FColCount then
  begin
    for col := FColCount - 1 downto Value do
      Self.FColumns[col].Free;
    for row := 0 to Self.FRowCount - 1 do
    begin
      for col := FColCount - 1 downto Value do
        Self.FCells[row, col].Free;
      SetLength(Self.FCells[row], Value);
    end;
    SetLength(Self.FColumns, Value);
  end;
  FColCount := Value;
end;

function TLMDDocTable.GetColumn(ACol: integer): TLMDTableColumn;
begin
  Result := Self.FColumns[ACol];
end;

{ TLMDDocElement }

constructor TLMDDocElement.Create;
begin
  inherited;

  FAutoSize := true;
  FCanGrow := true;

  FHeight := 0;
  FLeft := 0;
  FWidth := 0;
  FTop := 0;

  FPageNum := 0;
end;

procedure TLMDDocElement.PrepareForPrinting(APageCanvas: TCanvas;
                                            AMargins: TLMDMargins);
begin

end;

procedure TLMDDocTable.PrepareForPrinting(APageCanvas: TCanvas;
                                          AMargins: TLMDMargins);
var
  i: integer;
begin
  inherited;

  case Self.ColumnsWidthMode of
  cwmEqual:
    for i := 0 to Self.ColCount - 1 do
      Self.Columns[i].Width := Self.Width div Self.ColCount;

  cwmAutoSize:
    begin
    end;

  cwmManual:

  end;

end;

{ TLMDDocContainer }

constructor TLMDDocContainer.Create;
begin
  inherited;

  Self.FChildElements := TList.Create;
end;

destructor TLMDDocContainer.Destroy;
var
  I: integer;
begin
  for i := 0 to Self.FChildElements.Count - 1 do
    TObject(Self.FChildElements[i]).Free;

  Self.FChildElements.Free;

  inherited;
end;

procedure TLMDTableCellFormat.SetIsRTF(const Value: boolean);
begin
  FIsRTF := Value;
end;

procedure TLMDTableCell.SetStrings(const Value: TLMDStrings);
begin
  FStrings.Assign(Value);
end;

procedure TLMDTableCellFormat.Assign(Source: TPersistent);
var
  LSource: TLMDTableCellFormat;
begin
  if Source is TLMDTableCellFormat then
  begin
    LSource := Source as TLMDTableCellFormat;
    Self.TextFormat.Assign(LSource.TextFormat);
    Self.TopBorderPen.Assign(LSource.TopBorderPen);
    Self.RightBorderPen.Assign(LSource.RightBorderPen);
    Self.BottomBorderPen.Assign(LSource.BottomBorderPen);
    Self.LeftBorderPen.Assign(LSource.LeftBorderPen);
    Self.IsRTF := LSource.IsRTF;
    //Self.Margins.Assign(LSource.Margins);
    Self.Margins := LSource.Margins;
  end
  else
     inherited;
end;

{******************* Object TLMDTextAreaSettings ******************************}
{----------------------- public -----------------------------------------------}
procedure TLMDTextAreaSettings.Assign(Source: TPersistent);
var
  Src: TLMDTextAreaSettings;
begin
  if Source is TLMDTextAreaSettings then
  begin
    Src := Source as TLMDTextAreaSettings;

    FFont.Assign(Src.Font);
    FAlign := Src.Align;
    FReflowText := Src.ReflowText;
    FTabSize := Src.TabSize;
  end
  else
     inherited;
end;

constructor TLMDTextAreaSettings.Create;
begin
  inherited;

  FFont := TFont.Create;
  FFont.Name := 'Arial';

  FTabSize := 8;
  FAlign := laLeft;
  FReflowText := false;
  FIsRTF := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextAreaSettings.Destroy;
begin
  FFont.Free;

  inherited;
end;

procedure TLMDTextAreaSettings.SetFont(const Value: TFont);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument);

  FFont.Assign(Value);
end;

procedure TLMDTextAreaSettings.SetIsRTF(const Value: boolean);
begin
  FIsRTF := Value;
end;

procedure TLMDTextAreaSettings.SetTabSize(const Value: Integer);
begin
  if Value<=0 then
    raise ELMDPrintPackError.Create(SLMDPrintBadArgument);
    FTabSize := Value;
end;

{ TLMDDocImage }

constructor TLMDDocImage.Create;
begin
  inherited;

end;

procedure TLMDDocImage.SetPicture(const Value: TBitmap);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument);

  FPicture := Value;
end;

procedure TLMDDocImage.SetRect(const Value: TRect);
begin
  FRect := Value;
end;

end.
