unit LMDControlPrintTasks;
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

ControlPrintTasks unit (RS)
-----------------------------------
Contains print tasks for printing concrete VCL and LMD controls. These tasks are
based on general text, tables, images etc. printing  functionality implemented
in doc elements renderers, layour managers and basic print tasks

Changes
-------
* Not released yet

###############################################################################}

interface

uses
  Math, Classes, SysUtils, Controls, StdCtrls, ComCtrls, Grids, Windows, Printers,
  Graphics, Dialogs, Types,
  LMDTypes, LMDCustomComponent, LMDPrinter, LMDDocModel, LMDPrintablePage,
  LMDCustomPrintTask, LMDDocElementRenderer, LMDPageLayout, LMDSimpleDocLayout,
  LMDLayoutRenderPrintTask;

type
  TLMDCustomControlPrintTask = class(TLMDLayoutRenderPrintTask)
  protected
    procedure CreateLayoutManager; override;
    procedure ConstructDocument; override;
  published
    property About;
  end;

  TLMDTabularControlPrintTask = class;
 {******************* Object TLMDTableCellFormat *****************************}
  TLMDControlCellFormat = class (TPersistent)
  private
    FTopBorderPen: TPen;
    FBottomBorderPen: TPen;
    FRightBorderPen: TPen;
    FLeftBorderPen: TPen;
    FTextFormat: TLMDTextAreaSettings;
    FIsRTF: boolean;
    FMarginBottom: Double;
    FMarginTop: Double;
    FMarginLeft: Double;
    FMarginRight: Double;

    FParent: TLMDTabularControlPrintTask;

    procedure CheckMargin(Value: Double);

    procedure SetBottomBorderPen(const Value: TPen);
    procedure SetLeftBorderPen(const Value: TPen);
    procedure SetRightBorderPen(const Value: TPen);
    procedure SetTopBorderPen(const Value: TPen);
    procedure SetTextFormat(const Value: TLMDTextAreaSettings);
    procedure SetIsRTF(const Value: boolean);
    procedure SetMarginBottom(const Value: Double);
    procedure SetMarginLeft(const Value: Double);
    procedure SetMarginRight(const Value: Double);
    procedure SetMarginTop(const Value: Double);

    function IsMarginBottomStored: Boolean;
    function IsMarginLeftStored: Boolean;
    function IsMarginRightStored: Boolean;
    function IsMarginTopStored: Boolean;

    procedure ReadMarginsZero(Reader: TReader);
    procedure WriteMarginsZero(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AParent: TLMDTabularControlPrintTask);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property LeftBorderPen: TPen read FLeftBorderPen write SetLeftBorderPen;
    property RightBorderPen: TPen read FRightBorderPen write SetRightBorderPen;
    property TopBorderPen: TPen read FTopBorderPen write SetTopBorderPen;
    property BottomBorderPen: TPen read FBottomBorderPen write SetBottomBorderPen;
    property TextFormat: TLMDTextAreaSettings read FTextFormat write SetTextFormat;
    property IsRTF: boolean read FIsRTF write SetIsRTF default false;

    property MarginLeft: Double read FMarginLeft write SetMarginLeft
                                stored IsMarginLeftStored;
    property MarginRight: Double read FMarginRight write SetMarginRight
                                 stored IsMarginRightStored;
    property MarginTop: Double read FMarginTop write SetMarginTop
                               stored IsMarginTopStored;
    property MarginBottom: Double read FMarginBottom write SetMarginBottom
                                  stored IsMarginBottomStored;
  end;

  TLMDCustomEditPrintTask = class(TLMDCustomControlPrintTask)
  private
    FTextFormatOptions: TLMDTextAreaSettings;
    FEditControl: TCustomEdit;

    procedure SetTextFormatOptions(const Value: TLMDTextAreaSettings);
    procedure SetEditControl(const Value: TCustomEdit);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateLayoutManager; override;
    procedure ConstructDocument; override;
    procedure GetControlText(ATargetStrings: TLMDStrings); virtual;
    property  EditControl: TCustomEdit read FEditControl write SetEditControl;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property TextFormatOptions: TLMDTextAreaSettings read FTextFormatOptions write SetTextFormatOptions;
  end;

  TLMDEditPrintTask = class(TLMDCustomEditPrintTask)
  published
    property EditControl;
  end;

  TLMDTabularControlPrintTask = class(TLMDCustomControlPrintTask)
  private
    FFixedCellFormat: TLMDControlCellFormat;
    FCellFormat: TLMDControlCellFormat;

    procedure SetCellFormat(const Value: TLMDControlCellFormat);
    procedure SetFixedCellFormat(const Value: TLMDControlCellFormat);

    function GetDefaultMargin: Double;
  protected
    procedure CreateLayoutManager; override;
    procedure AssignCellFormats(ADest: TLMDTableCellFormat;
                                ASrc: TLMDControlCellFormat);

    procedure OnUnitsChanged(AOldUnits, ANewUnits: TLMDMeasureUnits); override;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CellFormat: TLMDControlCellFormat read FCellFormat write SetCellFormat;
    property FixedCellFormat: TLMDControlCellFormat read FFixedCellFormat write SetFixedCellFormat;

    property Units;
    property RealUnits;
  end;

  TLMDStringGridPrintTask = class(TLMDTabularControlPrintTask)
  private
    FGrid: TStringGrid;
    procedure SetGrid(const Value: TStringGrid);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ConstructDocument; override;
  public
    destructor Destroy; override;
  published
    property Grid: TStringGrid read FGrid write SetGrid;
  end;

  TLMDListViewPrintTask = class(TLMDTabularControlPrintTask)
  private
    FListView: TListView;
    procedure SetListView(const Value: TListView);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ConstructDocument; override;
  public
    destructor Destroy; override;
  published
    property ListView: TListView read FListView write SetListView;
  end;

implementation

uses LMDPrintConst, LMDConversion;

const MarginDefaultMM = 3.0;
var MarginDefaultInch: Double;

procedure CheckNilArg(Value: TObject);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument);
end;
{ TLMDCustomEditPrintTask }

procedure TLMDCustomEditPrintTask.ConstructDocument;
var
  LTextBlock: TLMDTextBlock;
begin
  inherited;

    LTextBlock := TLMDTextBlock.Create;
    LTextBlock.Top := 0;
    LTextBlock.Left := 0;

    Assert(FPageWidth<>-1);
    LTextBlock.Width := FPageWidth;

    Self.GetControlText(LTextBlock.Strings);
    LTextBlock.TextFormat := Self.TextFormatOptions;
    LTextBlock.IsRTF := Self.TextFormatOptions.IsRTF;

    Self.FDocument.ChildElements.Add(LTextBlock);
end;

constructor TLMDCustomEditPrintTask.Create(AOwner: TComponent);
begin
  inherited;
  FTextFormatOptions := TLMDTextAreaSettings.Create;
end;

procedure TLMDCustomEditPrintTask.CreateLayoutManager;
begin
  FLayout := TLMDSimpleDocLayout.Create;
end;

destructor TLMDCustomEditPrintTask.Destroy;
begin
  FTextFormatOptions.Free;

  SetEditControl(nil);

  inherited;
end;

procedure TLMDCustomEditPrintTask.SetEditControl(const Value: TCustomEdit);
begin
  if FEditControl<>nil then
    FEditControl.RemoveFreeNotification(Self);

  FEditControl := Value;

  if FEditControl<>nil then
    FEditControl.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomEditPrintTask.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Operation<>opRemove then
    Exit;

  if AComponent = FEditControl then
    FEditControl := nil;

  inherited;
end;

procedure TLMDCustomEditPrintTask.SetTextFormatOptions(
  const Value: TLMDTextAreaSettings);
begin
  CheckNilArg(Value);
  Self.FTextFormatOptions.Assign(Value);
end;

procedure TLMDCustomEditPrintTask.GetControlText(ATargetStrings: TLMDStrings);
var
  LRichEdit: TRichEdit;
begin
  if Assigned(Self.EditControl) and Assigned(ATargetStrings) then
  begin
    if Self.EditControl is TCustomRichEdit then
    begin
      LRichEdit := Self.EditControl as TRichEdit;
      SaveRTFLines(ATargetStrings, LRichEdit);
    end
    else
      ATargetStrings.Text := Self.EditControl.Text;
  end;
end;

{ TLMDCustomControlPrintTask }

procedure TLMDCustomControlPrintTask.ConstructDocument;
begin
  CheckPagesNotPrepared;

  Self.FDocument := TLMDDocument.Create;
end;

procedure TLMDCustomControlPrintTask.CreateLayoutManager;
begin
  FLayout := TLMDSimpleDocLayout.Create;
end;

{ TLMDTabularControlPrintTask }

procedure TLMDTabularControlPrintTask.AssignCellFormats(
  ADest: TLMDTableCellFormat;
  ASrc: TLMDControlCellFormat);
begin
  CheckNilArg(ADest);
  CheckNilArg(ASrc);

  CheckPrinterAssigned;

  ADest.LeftBorderPen.Assign(ASrc.LeftBorderPen);
  ADest.RightBorderPen.Assign(ASrc.RightBorderPen);
  ADest.TopBorderPen.Assign(ASrc.TopBorderPen);
  ADest.BottomBorderPen.Assign(ASrc.BottomBorderPen);

  ADest.TextFormat.Assign(ASrc.TextFormat);
  ADest.IsRTF := ASrc.IsRTF;

  ADest.Margins.Left := FUtilPrinter.UnitsToPixelsX(ASrc.MarginLeft);
  ADest.Margins.Right := FUtilPrinter.UnitsToPixelsX(ASrc.MarginRight);
  ADest.Margins.Top := FUtilPrinter.UnitsToPixelsX(ASrc.MarginTop);
  ADest.Margins.Bottom := FUtilPrinter.UnitsToPixelsX(ASrc.MarginBottom);
end;

constructor TLMDTabularControlPrintTask.Create(AOwner: TComponent);
begin
  inherited;

  Self.FCellFormat := TLMDControlCellFormat.Create(Self);
  Self.FFixedCellFormat := TLMDControlCellFormat.Create(Self);
end;

procedure TLMDTabularControlPrintTask.CreateLayoutManager;
begin
  FLayout := TLMDSimpleDocLayout.Create;
end;

destructor TLMDTabularControlPrintTask.Destroy;
begin
  Self.FCellFormat.Free;
  Self.FFixedCellFormat.Free;
  inherited;
end;

function TLMDTabularControlPrintTask.GetDefaultMargin: Double;
begin
  case RealUnits of
    unMillimeters: Result := MarginDefaultMM;
    unInches: Result := MarginDefaultInch;
  else
    Result := 0;
    Assert(false);
  end;
end;

procedure TLMDTabularControlPrintTask.OnUnitsChanged(AOldUnits,
  ANewUnits: TLMDMeasureUnits);
var
    F, Def, Def2: Double;

function Convert(Val: Double): Double;
begin
  if Val<>Def then
    Result := Round(F * FUtilPrinter.UnitsToUnits(AOldUnits,
                                                  ANewUnits, Val))/F
  else
    Result := Def2;
end;

var Fmt: TLMDControlCellFormat;
begin
  if AOldUnits<>ANewUnits then
  begin
    F := 0; Def := 0; Def2 := 0;

    case ANewUnits of
      unMillimeters:
      begin
        F := 10; Def := MarginDefaultInch; Def2 := MarginDefaultMM;
      end;
      unInches:
      begin
        F:= 100;
        Def := MarginDefaultMM; Def2 := MarginDefaultInch;
      end;
    else
      Assert(false);
    end;

    Fmt := FFixedCellFormat;

    Fmt.MarginLeft := Convert(Fmt.MarginLeft);
    Fmt.MarginRight := Convert(Fmt.MarginRight);
    Fmt.MarginTop := Convert(Fmt.MarginTop);
    Fmt.MarginBottom := Convert(Fmt.MarginBottom);

    Fmt := FCellFormat;

    Fmt.MarginLeft := Convert(Fmt.MarginLeft);
    Fmt.MarginRight := Convert(Fmt.MarginRight);
    Fmt.MarginTop := Convert(Fmt.MarginTop);
    Fmt.MarginBottom := Convert(Fmt.MarginBottom);
  end;
end;

procedure TLMDTabularControlPrintTask.SetCellFormat(
  const Value: TLMDControlCellFormat);
begin
  CheckNilArg(Value);
  FCellFormat.Assign(Value);
end;

procedure TLMDTabularControlPrintTask.SetFixedCellFormat(
  const Value: TLMDControlCellFormat);
begin
  CheckNilArg(Value);
  FFixedCellFormat.Assign(Value);
end;

{ TLMDStringGridPrintTask }

procedure TLMDStringGridPrintTask.SetGrid(const Value: TStringGrid);
begin
  if FGrid<>nil then
    FGrid.RemoveFreeNotification(Self);

  FGrid := Value;

  if FGrid<>nil then
    FGrid.FreeNotification(Self);
end;

destructor TLMDStringGridPrintTask.Destroy;
begin
  SetGrid(nil);
  inherited;
end;

procedure TLMDStringGridPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (Operation = opRemove) then
    Exit;

  if AComponent = FGrid then
    FGrid := nil;

  inherited;
end;

procedure TLMDStringGridPrintTask.ConstructDocument;
var
  LTable: TLMDDocTable;
  i, j: integer;
begin
  inherited;

  if Assigned(Self.Grid) then
  begin
    LTable := TLMDDocTable.Create;
    LTable.Left := 0;
    LTable.ColCount := Self.Grid.ColCount;
    LTable.RowCount := Self.Grid.RowCount;
    AssignCellFormats(LTable.DefaultCellFormat, Self.CellFormat);
    for i := 0 to Self.Grid.RowCount - 1 do
      for j := 0 to Self.Grid.ColCount - 1 do
      begin
        LTable.Cell[i, j].Strings.Text := Self.Grid.Cells[j, i];
        if (i < Self.Grid.FixedRows) or (j < Self.Grid.FixedCols) then
        begin
          LTable.Cell[i, j].HasSpecialFormat := true;
          AssignCellFormats(LTable.Cell[i, j].CellFormat, Self.FixedCellFormat);
        end;
      end;
    Self.FDocument.ChildElements.Add(LTable);
  end;
end;

{ TLMDListViewPrintTask }

procedure TLMDListViewPrintTask.ConstructDocument;
var
  LTable: TLMDDocTable;
  i, j: integer;
begin
  inherited;

  if Assigned(Self.ListView) then
  begin
    LTable := TLMDDocTable.Create;
    LTable.Left := 0;
    LTable.ColCount := Self.ListView.Columns.Count;
    LTable.RowCount := Self.ListView.Items.Count + 1;
    AssignCellFormats(LTable.DefaultCellFormat, Self.CellFormat);

    for j := 0 to Self.ListView.Columns.Count - 1 do
    begin
      LTable.Cell[0, j].Strings.Text := Self.ListView.Columns[j].Caption;
      AssignCellFormats(LTable.Cell[0, j].CellFormat, Self.FixedCellFormat);

      LTable.Cell[0, j].HasSpecialFormat := true;

      for i := 0 to Self.ListView.Items.Count - 1 do
      begin
        if j = 0 then
          LTable.Cell[i + 1, j].Strings.Text := Self.ListView.Items[i].Caption
        else
          LTable.Cell[i + 1, j].Strings.Text := Self.ListView.Items[i].SubItems.Strings[j-1];
      end;
    end;
    Self.FDocument.ChildElements.Add(LTable);
  end;
end;

destructor TLMDListViewPrintTask.Destroy;
begin
  SetListView(nil);

  inherited;
end;

procedure TLMDListViewPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (Operation = opRemove) then
    Exit;

  if AComponent = FListView then
    FListView := nil;

  inherited;
end;

procedure TLMDListViewPrintTask.SetListView(const Value: TListView);
begin
  if FListView<>nil then
    FListView.RemoveFreeNotification(Self);

  FListView := Value;

  if FListView<>nil then
    FListView.FreeNotification(Self);
end;

{ TLMDTableCellFormat }

procedure TLMDControlCellFormat.Assign(Source: TPersistent);
var
    Src: TLMDControlCellFormat;
begin
  CheckNilArg(Source);

  if Source is TLMDControlCellFormat then
  begin
    Src := Source as TLMDControlCellFormat;

    if Src=Self then
      Exit;

    LeftBorderPen := Src.LeftBorderPen;
    RightBorderPen := Src.RightBorderPen;
    TopBorderPen := Src.TopBorderPen;
    BottomBorderPen := Src.BottomBorderPen;
    TextFormat := Src.TextFormat;
    IsRTF := Src.IsRTF;

    MarginLeft := Src.MarginLeft;
    MarginRight := Src.MarginRight;
    MarginTop := Src.MarginTop;
    MarginBottom := Src.MarginBottom;
  end
  else
    inherited;
end;

procedure TLMDControlCellFormat.CheckMargin(Value: Double);
begin
  if Value<0 then
    raise ELMDPrintPackError.Create(SLMDPrintBadMarginsValue)
end;

constructor TLMDControlCellFormat.Create(AParent: TLMDTabularControlPrintTask);
begin
  inherited Create;

  CheckNilArg(AParent);

  FParent := AParent;

  Self.FMarginTop := FParent.GetDefaultMargin;
  Self.FMarginLeft := FParent.GetDefaultMargin;
  Self.FMarginRight := FParent.GetDefaultMargin;
  Self.FMarginBottom := FParent.GetDefaultMargin;

  Self.FTopBorderPen := TPen.Create;
  Self.FLeftBorderPen := TPen.Create;
  Self.FRightBorderPen := TPen.Create;
  Self.FBottomBorderPen := TPen.Create;

  Self.FTextFormat := TLMDTextAreaSettings.Create;
end;

procedure TLMDControlCellFormat.DefineProperties(Filer: TFiler);
var
    HasData: Boolean;
begin
  HasData := (FMarginLeft=0) or (FMarginRight=0) or (FMarginTop=0) or
             (FMarginBottom=0);

  Filer.DefineProperty('MarginsZero', ReadMarginsZero, WriteMarginsZero,
                       HasData);
end;

destructor TLMDControlCellFormat.Destroy;
begin
  Self.FTopBorderPen.Free;
  Self.FLeftBorderPen.Free;
  Self.FRightBorderPen.Free;
  Self.FBottomBorderPen.Free;
  Self.FTextFormat.Free;

  inherited;
end;

function TLMDControlCellFormat.IsMarginBottomStored: Boolean;
begin
  Result := FMarginBottom<>FParent.GetDefaultMargin;
end;

function TLMDControlCellFormat.IsMarginLeftStored: Boolean;
begin
  Result := FMarginLeft<>FParent.GetDefaultMargin;
end;

function TLMDControlCellFormat.IsMarginRightStored: Boolean;
begin
  Result := FMarginRight<>FParent.GetDefaultMargin;
end;

function TLMDControlCellFormat.IsMarginTopStored: Boolean;
begin
  Result := FMarginTop<>FParent.GetDefaultMargin;
end;

procedure TLMDControlCellFormat.ReadMarginsZero(Reader: TReader);
var
    s: string;
begin
  s := LowerCase(Reader.ReadString);

  if Pos('left', s)<>0 then
    FMarginLeft := 0;

  if Pos('right', s)<>0 then
    FMarginRight := 0;

  if Pos('top', s)<>0 then
    FMarginTop := 0;

  if Pos('bottom', s)<>0 then
    FMarginBottom := 0;
end;

procedure TLMDControlCellFormat.SetBottomBorderPen(const Value: TPen);
begin
  CheckNilArg(Value);

  FBottomBorderPen.Assign(Value);
end;

procedure TLMDControlCellFormat.SetIsRTF(const Value: boolean);
begin
  FIsRTF := Value;
end;

procedure TLMDControlCellFormat.SetLeftBorderPen(const Value: TPen);
begin
  CheckNilArg(Value);
  FLeftBorderPen.Assign(Value);
end;

procedure TLMDControlCellFormat.SetMarginBottom(const Value: Double);
begin
  CheckMargin(Value);
  FMarginBottom := Value;
end;

procedure TLMDControlCellFormat.SetMarginLeft(const Value: Double);
begin
  CheckMargin(Value);

  FMarginLeft := Value;
end;

procedure TLMDControlCellFormat.SetMarginRight(const Value: Double);
begin
  CheckMargin(Value);
  FMarginRight := Value;
end;

procedure TLMDControlCellFormat.SetMarginTop(const Value: Double);
begin
  CheckMargin(Value);

  FMarginTop := Value;
end;

procedure TLMDControlCellFormat.SetRightBorderPen(const Value: TPen);
begin
  CheckNilArg(Value);
  FRightBorderPen.Assign(Value);
end;

procedure TLMDControlCellFormat.SetTextFormat(const Value: TLMDTextAreaSettings);
begin
  CheckNilArg(Value);
  FTextFormat.Assign(Value);
end;

procedure TLMDControlCellFormat.SetTopBorderPen(const Value: TPen);
begin
  CheckNilArg(Value);
  FTopBorderPen.Assign(Value);
end;

procedure TLMDControlCellFormat.WriteMarginsZero(Writer: TWriter);
var
    s: string;
begin
  s := '';

  if FMarginLeft=0 then
    s := s + 'left';

  if FMarginRight=0 then
  begin
    if s<>'' then
      s := s + ',right'
    else
      s := s + 'right';
  end;

  if FMarginTop=0 then
  begin
    if s<>'' then
      s := s + ',top'
    else
      s := s + 'top';
  end;

  if FMarginBottom=0 then
  begin
    if s<>'' then
      s := s + ',bottom'
    else
      s := s + 'bottom';
  end;

  s := '['+s+']';

  Writer.WriteString(s);
end;

initialization
  MarginDefaultInch := Round(100 * MarginDefaultMM / MillimetersPerInch )/100;

end.
