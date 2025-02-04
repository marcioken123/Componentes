{******************************************************************************}
{                                                                              }
{                          GmPreview.pas v2.61 Lite                            }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmPreview;

interface

uses Windows, Classes, Controls, Forms, GmTypes, GmCanvas, Graphics,
  Messages, GmPrinter, GmConst, GmRtfFuncs;

const
  // cursor values...
  crZoomIn   = 101;
  crZoomOut  = 102;

  {$I GMPS.INC}

type
  // *** TGmPreview ***

  TGmPreview = class(TGmScrollingWinControl)
  private
    FBorderStyle: TBorderStyle;
    FCanvas: TGmCanvas;
    FCoordsRelativeTo: TGmCoordsRelative;
    FCurrentPage: integer;
    FFooter: TGmHeaderFooter;
    FGutter: integer;
    FHeader: TGmHeaderFooter;
    FMargins: TGmMargins;
    FMaxZoom: integer;
    FMinZoom: integer;
    FMouseOver: Boolean;
    FMousePos: TPoint;
    FOrientation: TGmOrientation;
    FPages: TGmPageList;
    FPagesPerSheet: TGmPagesPerSheet;
    FPanning: Boolean;
    FPanningXYStart : TPoint;
    FPaper: TGmPageCanvas;  // obsolete property.
    FPaperImage: TGmPaperImage;
    FPaperSize: TGmPaperSize;
    FPrinter: TGmPrinter;
    FRegisteredComponents: TList;
    FReversePrintOrder: Boolean;
    FShadow: TGmShadow;
    FTempInt: integer;
    FTempValue: TGmValue;
    FUpdateCount: integer;
    FZoom: integer;
    FZoomIncrement: integer;
    FZoomStyle: TGmZoomStyle;
    // events...
    FAfterPrint       : TNotifyEvent;
    FAfterPrintPage   : TPrintPageEvent;
    FBeforeLoad       : TBeforeLoadEvent;
    FBeforePrint      : TNotifyEvent;
    FBeforePrintPage  : TPrintPageEvent;
    FBeforeReadStream : TBeforeReadWriteStream;
    FBeforeWriteStream: TBeforeReadWriteStream;
    FNeedRichEdit     : TNeedRichEditEvent;
    FOnAbortPrint     : TNotifyEvent;
    FOnCanvasChange   : TNotifyEvent;
    FOnChangeOrientation: TNotifyEvent;
    FOnChangePageOrientation: TPageOrientationChanged;
    FOnChangePrinter  : TNotifyEvent;
    FOnClear          : TNotifyEvent;
    FOnDeletePage     : TNotifyEvent;
    FOnLoadProgress   : TFileProgressEvent;
    FOnMarginsChange  : TNotifyEvent;
    FOnNewPage        : TNotifyEvent;
    FOnPageChange     : TPageChangeEvent;
    FOnPageChanging   : TPageChangeEvent;
    FOnPrintPage      : TPrintPageEvent;
    FOnPrintProgress  : TPrintProgressEvent;
    FOnSaveProgress   : TFileProgressEvent;
    FOnZoom           : TZoomEvent;
    FOnPageDragDrop   : TPageDragDropEvent;
    FOnPageDragOver   : TPageDragOverEvent;
    FOnPageMouseDown  : TPageMouseEvent;
    FOnPageMouseMove  : TPageMouseMoveEvent;
    FOnPageMouseUp    : TPageMouseEvent;
    FOnPageSizeChange : TNotifyEvent;
    function GetAvailablePageHeight: TGmValue;
    function GetAvailablePageWidth: TGmValue;
    function GetGmValue: TGmValue;
    function GetMessagesEnabled: Boolean;
    function GetNumPages: integer;
    function GetOrientationType: TGmOrientationType;
    function GetPage(index: integer): TGmPage;
    function GetPageHeight: TGmValue;
    function GetPageWidth: TGmValue;
    function GetPrintCopies: integer;
    function GetRtfInformation: TGmRtfInformation;
    function GetScale: Extended;
    function GetScrollbarPercents: TGmPoint;
    function GetTitle: string;
    function IsUpdating: Boolean;
    procedure ForceMessageToControls(AMessage: integer; Param1, Param2: integer);
    procedure LoadDocInfoFromStream(AStream: TStream; var ANumPages: integer);
    procedure LoadPageSetupFromStream(AStream: TStream);
    procedure MessageToControls(AMessage: integer; Param1, Param2: integer);
    procedure PageSizeChanged(Sender: TObject);
    procedure HeaderFooterChanged(Sender: TObject);
    procedure PageChanged;
    procedure SaveDocInfoToStream(AStream: TStream);
    procedure SavePageSetupToStream(AStream: TStream);
    procedure SetCoordsRelative(const AValue: TGmCoordsRelative);
    procedure SetCurrentPage(AValue: integer);
    procedure SetGutter(AValue: integer);
    procedure SetMaxZoom(const AValue: integer);
    procedure SetMessagesEnabled(const AValue: Boolean);
    procedure SetMinZoom(const AValue: integer);
    procedure SetOrientation(AValue: TGmOrientation);
    procedure SetPagesPerSheet(AValue: TGmPagesPerSheet);
    procedure SetPaperSize(AValue: TGmPaperSize);
    procedure SetPrintCopies(AValue: integer);
    procedure SetTitle(ATitle: string);
    procedure SetZoom(AValue: integer);
    // events...
    procedure CanvasChanged(Sender: TObject);
    procedure MarginsChanged(Sender: TObject);
    procedure PrinterChanged(Sender: TObject);
    procedure PageOrientationChanged(Sender: TObject; APageNum: integer; AOrientation: TGmOrientation);
  protected
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);

    procedure DoPageDragDrop(Sender, Source: TObject; X, Y: TGmValue);
    procedure DoPageDragOver(Sender, Source: TObject; X, Y: TGmValue; State: TDragState; var Accept: Boolean);
    procedure DoPageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: TGmValue);
    procedure DoPageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: TGmValue);
    procedure DoPageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: TGmValue);
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure PreviewResize(var Message: TMessage); message WM_SIZE;
    procedure WMNCHitTest(var Message: TMessage); message WM_NCHITTEST;
    procedure ChangeDrawingDpi(var Message: TMessage); message GM_CHANGE_DRAWING_PPI;
    procedure DefaultDrawingDpi(var Message: TMessage); message GM_DEFAULT_DRAWING_PPI;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFileVersion(AFileName: string): Extended;
    function NewPage: TGmPage; virtual;
    function PaperSizeToStr(APaperSize: TGmPaperSize): string;
    function Tokenize(AText: string; APage: integer): string;
    procedure AddAssociatedComponent(AComponent: TComponent);
    procedure RemoveAssociatedComponent(AComponent: TComponent);
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure CenterOnClick(x, y: integer);
    procedure Clear; virtual;
    procedure DeleteCurrentPage;
    procedure DeletePage(index: integer);
    procedure EndUpdate;
    procedure FindText(AText: string; CaseSensative: Boolean; AList: TList);
    procedure FirstPage;
    procedure FitHeight;
    procedure FitWidth;
    procedure FitWholePage;
    procedure LastPage;
    procedure LoadFromStream(AStream: TStream);
    procedure LoadFromFile(AFilename: string);
    procedure NextPage;
    procedure PrevPage;
    procedure Print;
    procedure PrintCurrentPage;
    procedure PrintRange(APageFrom, APageTo: integer);
    procedure PrintToFile(AFileName: string);
    procedure SaveToFile(AFilename: string);
    procedure SaveToStream(AStream: TStream);
    procedure ScrollToPosition(XPercent, YPercent: Extended);
    procedure SetCursor(ACursor: TGmCursor);
    procedure SetPageSize(AWidth, AHeight: Extended; AUnits: TGmMeasurement);
    procedure StartPanning;
    procedure StopPanning;
    procedure UpdatePreview;
    procedure UsePrinterPageSize;
    procedure ZoomIn;
    procedure ZoomOut;
    property AvailablePageHeight: TGmValue read GetAvailablePageHeight;
    property AvailablePageWidth: TGmValue read GetAvailablePageWidth;
    property Canvas: TGmCanvas read FCanvas;
    property CurrentPage: integer read FCurrentPage write SetCurrentPage;
    property MessagesEnabled: Boolean read GetMessagesEnabled write SetMessagesEnabled;
    property NumPages: integer read GetNumPages;
    property PageHeight: TGmValue read GetPageHeight;

    property Pages[index: integer]: TGmPage read GetPage;
    property PageWidth: TGmValue read GetPageWidth;
    property Panning: Boolean read FPanning;
    property Paper: TGmPageCanvas read FPaper;
    property RtfInformation: TGmRtfInformation read GetRtfInformation;
  published
    {properties available from Delphi 4...}
    {$IFNDEF VER100}
    {$IFNDEF VER110}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$ENDIF}
    property Align;
    property AutoScroll;
    property BorderStyle: TBorderStyle read FBorderStyle write FBorderStyle;
    property Color default clGray;
    property CoordsRelativeTo: TGmCoordsRelative read FCoordsRelativeTo write SetCoordsRelative;
    property Footer: TGmHeaderFooter read FFooter write FFooter;
    property GmPrinter: TGmPrinter read FPrinter write FPrinter;
    property Gutter: integer read FGutter write SetGutter default DEFAULT_GUTTER;
    property Header: TGmHeaderFooter read FHeader write FHeader;
    property Hint;
    property Margins: TGmMargins read FMargins write FMargins;
    property MaxZoom: integer read FMaxZoom write SetMaxZoom default DEFAULT_MAX_ZOOM;
    property MinZoom: integer read FMinZoom write SetMinZoom default DEFAULT_MIN_ZOOM;
    property Orientation: TGmOrientation read FOrientation write SetOrientation default gmPortrait;
    property PagesPerSheet: TGmPagesPerSheet read FPagesPerSheet write SetPagesPerSheet default gmOnePage;
    property PaperSize: TGmPaperSize read FPaperSize write SetPaperSize default A4;
    property ParentColor;
    property PopupMenu;
    property PrintCopies: integer read GetPrintCopies write SetPrintCopies;
    property ReversePrintOrder: Boolean read FReversePrintOrder write FReversePrintOrder default False;
    property Shadow: TGmShadow read FShadow write FShadow;
    property ShowHint;
    property TabOrder;
    property Title: string read GetTitle write SetTitle;
    property Visible;
    property Zoom: integer read FZoom write SetZoom default DEFAULT_ZOOM;
    property ZoomIncrement: integer read FZoomIncrement write FZoomIncrement default DEFAULT_ZOOM_INC;
    property ZoomStyle: TGmZoomStyle read FZoomStyle write FZoomStyle default gmFixedZoom;
    // events...
    property AfterPrint: TNotifyEvent read FAfterPrint write FAfterPrint;
    property AfterPrintPage: TPrintPageEvent read FAfterPrintPage write FAfterPrintPage;
    property BeforeLoad: TBeforeLoadEvent read FBeforeLoad write FBeforeLoad;
    property BeforePrint: TNotifyEvent read FBeforePrint write FBeforePrint;
    property BeforePrintPage: TPrintPageEvent read FBeforePrintPage write FBeforePrintPage;
    property BeforeReadStream: TBeforeReadWriteStream read FBeforeReadStream write FBeforeReadStream;
    property BeforeWriteStream: TBeforeReadWriteStream read FBeforeWriteStream write FBeforeWriteStream;
    property OnAbortPrint: TNotifyEvent read FOnAbortPrint write FOnAbortPrint;
    property OnCanvasChange: TNotifyEvent read FOnCanvasChange write FOnCanvasChange;
    property OnChangeMargins: TNotifyEvent read FOnMarginsChange write FOnMarginsChange;
    property OnChangeOrientation: TNotifyEvent read FOnChangeOrientation write FOnChangeOrientation;
    property OnChangePageOrientation: TPageOrientationChanged read FOnChangePageOrientation write FOnChangePageOrientation;
    property OnChangePrinter: TNotifyEvent read FOnChangePrinter write FOnChangePrinter;
    property OnClear: TNotifyEvent read FOnClear write FOnClear;
    property OnDeletePage: TNotifyEvent read FOnDeletePage write FOnDeletePage;
    property OnDragOver;
    property OnDragDrop;
    property OnEndDrag;
    property OnLoadProgress: TFileProgressEvent read FOnLoadProgress write FOnLoadProgress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnNeedRichEdit: TNeedRichEditEvent read FNeedRichEdit write FNeedRichEdit;
    property OnNewPage: TNotifyEvent read FOnNewPage write FOnNewPage;
    property OnPageChange: TPageChangeEvent read FOnPageChange write FOnPageChange;
    property OnPageChanging: TPageChangeEvent read FOnPageChanging write FOnPageChanging;
    property OnPageDragDrop: TPageDragDropEvent read FOnPageDragDrop write FOnPageDragDrop;
    property OnPageDragOver: TPageDragOverEvent read FOnPageDragOver write FOnPageDragOver;
    property OnPageMouseDown: TPageMouseEvent read FOnPageMouseDown write FOnPageMouseDown;
    property OnPageMouseMove: TPageMouseMoveEvent read FOnPageMouseMove write FOnPageMouseMove;
    property OnPageMouseUp: TPageMouseEvent read FOnPageMouseUp write FOnPageMouseUp;
    property OnPageSizeChange: TNotifyEvent read FOnPageSizeChange write FOnPageSizeChange;
    property OnPrintPage: TPrintPageEvent read FOnPrintPage write FOnPrintPage;
    property OnPrintProgress: TPrintProgressEvent read FOnPrintProgress write FOnPrintProgress;
    property OnSaveProgress: TFileProgressEvent read FOnSaveProgress write FOnSaveProgress;
    property OnStartDrag;
    property OnZoom: TZoomEvent read FOnZoom write FOnZoom;
  end;

implementation

{$R GmCursors.res}

uses SysUtils, GmErrors, GmObjects, Math, GmStream;
//------------------------------------------------------------------------------

// *** TGmPreview Constructor/Destructor ***

constructor TGmPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inc(FUpdateCount);

  // create objects...
  FRegisteredComponents := TList.Create;
  FPrinter := TGmPrinter.Create;
  FPages := TGmPageList.Create;
  FCanvas := TGmCanvas.Create(Self);
  FHeader := TGmHeader.Create;
  FFooter := TGmFooter.Create;
  FMargins := TGmMargins.Create;
  FShadow := TGmShadow.Create;
  FPaperImage := TGmPaperImage.Create(Self);
//  FPageHeight := TGmValue.Create;
//  FPageWidth := TGmValue.Create;

  // set object events...
  FHeader.OnChange := HeaderFooterChanged;
  FFooter.OnChange := HeaderFooterChanged;
  FPages.OnChange := PageSizeChanged;
  FPages.OnPageOrientationChange := PageOrientationChanged;

  FPaperImage.OnPageMouseDown := DoPageMouseDown;
  FPaperImage.OnPageMouseMove := DoPageMouseMove;
  FPaperImage.OnPageMouseUp := DoPageMouseUp;
  FPaperImage.OnPageDragDrop := DoPageDragDrop;
  FPaperImage.OnPageDragOver := DoPageDragOver;

  FPaperImage.OnMouseDown := DoMouseDown;
  FPaperImage.OnMouseMove := DoMouseMove;
  FPaperImage.OnMouseUp   := DoMouseUp;

  FPrinter.OnPrinterChanged := PrinterChanged;
  FCanvas.OnChange := CanvasChanged;
  FMargins.OnChange := MarginsChanged;
  // link objects...
  FMargins.Printer := FPrinter;
  FPaperImage.Shadow := FShadow;
  FPaperImage.Margins := FMargins;
  FPages.Header := FHeader;
  FPages.Footer := FFooter;
  FPages.Margins := FMargins;
  FPages.Preview := Self;
  FHeader.Margins := FMargins;
  FFooter.Margins := FMargins;
  FHeader.Preview := Self;
  FFooter.Preview := Self;
  // load cursors...
  Screen.Cursors[crZoomIn]  := LoadCursor(HInstance, 'ZoomIn');
  Screen.Cursors[crZoomOut] := LoadCursor(HInstance, 'ZoomOut');

  // set properties...
  Color := clGray;
  Height := DEFAULT_HEIGHT;
  Width := DEFAULT_WIDTH;
  {$IFNDEF VER100} {$IFNDEF VER110}
  DoubleBuffered := True;
  {$ENDIF} {$ENDIF}
  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption, csDoubleClicks];
  FBorderStyle := bsSingle;
  FPages.AddPage;
  FCurrentPage := 1;
  FCanvas.Page := Pages[FCurrentPage];
  FGutter := DEFAULT_GUTTER;
  FOrientation := gmPortrait;
  FPaperSize := A4;
  FPaperImage.Parent := Self;
  FMaxZoom := DEFAULT_MAX_ZOOM;
  FMinZoom := DEFAULT_MIN_ZOOM;
  FZoom := DEFAULT_ZOOM;
  FZoomIncrement := DEFAULT_ZOOM_INC;
  FZoomStyle := gmFixedZoom;
  FPagesPerSheet := gmOnePage;
  FReversePrintOrder := False;
  Dec(FUpdateCount);
end;

destructor TGmPreview.Destroy;
begin
  FCanvas.Free;
  FMargins.Free;
  FPages.Free;
  FHeader.Free;
  FFooter.Free;
  FPrinter.Free;
  FShadow.Free;
  FPaperImage.Free;
  FRegisteredComponents.Free;
  if Assigned(FTempValue) then FTempValue.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

function TGmPreview.GetAvailablePageHeight: TGmValue;
begin
  Result := GetGmValue;
  Result.AsUnits := PageHeight.AsUnits - ((Margins.Top.AsUnits + Margins.Bottom.AsUnits) +
                                          (Header.Height.AsUnits + Footer.Height.AsUnits));
end;

function TGmPreview.GetAvailablePageWidth: TGmValue;
begin
  Result := GetGmValue;
  Result.AsUnits := PageWidth.AsUnits - (Margins.Left.AsUnits + Margins.Right.AsUnits);
end;

function TGmPreview.GetGmValue: TGmValue;
begin
  if not Assigned(FTempValue) then FTempValue := TGmValue.Create;
  Result := FTempValue;
  Result.OnChange := nil;
end;

function TGmPreview.GetMessagesEnabled: Boolean;
begin
  Result := FUpdateCount = 0;
end;

function TGmPreview.GetNumPages: integer;
begin
  Result := FPages.Count;
end;

function TGmPreview.GetOrientationType: TGmOrientationType;
begin
  Result := FPages.GetOrientationType;
end;

function TGmPreview.GetPage(index: integer): TGmPage;
begin
  Result := nil;
  if (index >= 1) or (index <= FPages.Count) then
  Result := FPages.Page[index];
end;

function TGmPreview.GetPageHeight: TGmValue;
begin
//  Result := GetGmValue;
//  Result.OnChange := PageSizeChanged;
//  Result.Assign(FPages.PageHeight);
  Result := FPages.PageHeight;
end;

function TGmPreview.GetPageWidth: TGmValue;
begin
  //Result := GetGmValue;
  //Result.OnChange := PageSizeChanged;
  Result := FPages.PageWidth;//.Assign(FPages.PageWidth);
end;

function TGmPreview.GetPrintCopies: integer;
begin
  Result := FPrinter.PrintCopies;
end;

function TGmPreview.GetRtfInformation: TGmRtfInformation;
begin
  Result := (FPages.RtfInformation as TGmRtfInformation);
end;

function TGmPreview.GetScale: Extended;
begin
  Result := FZoom / 100;
end;

function TGmPreview.GetScrollbarPercents: TGmPoint;
begin
  if (HorzScrollBar.Range > 0) and (HorzScrollBar.Position > 0) then
    Result.x := 100 * (HorzScrollBar.Position / (HorzScrollBar.Range-ClientWidth))
  else
    Result.x := 0;
  if (VertScrollBar.Range > 0) and (VertScrollBar.Position > 0) then
    Result.y := 100 * (VertScrollBar.Position / (VertScrollBar.Range-ClientHeight))
  else
    Result.y := 0;
end;

function TGmPreview.GetTitle: string;
begin
  Result := GmPrinter.Title;
end;

function TGmPreview.IsUpdating: Boolean;
begin
  Result := (FUpdateCount <> 0);
end;

procedure TGmPreview.ForceMessageToControls(AMessage: integer; Param1, Param2: integer);
var
  FTempValue: integer;
begin
  FTempValue := FUpdateCount;
  try
    FUpdateCount := 0;
    MessageToControls(AMessage, Param1, Param2);
  finally
    FUpdateCount := FTempValue;
  end;
end;

procedure TGmPreview.LoadDocInfoFromStream(AStream: TStream; var ANumPages: integer);
var
  GmStream: TGmExtStream;
begin
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    GmStream.ReadDateTime;
    ANumPages := GmStream.ReadInteger;
  finally
    GmStream.Free;
  end;
end;

procedure TGmPreview.LoadPageSetupFromStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FPages.PageWidth.AsUnits  := GmStream.ReadInteger;
    FPages.PageHeight.AsUnits := GmStream.ReadInteger;
    FPaperSize := StrToPaperSize(GmStream.ReadStr);
    Orientation := TGmOrientation(GmStream.ReadInteger);
    Shadow.Color := GmStream.ReadInteger;
    Shadow.Width := GmStream.ReadInteger;
  finally
    GmStream.Free;
  end;
end;

procedure TGmPreview.MessageToControls(AMessage: integer; Param1, Param2: integer);
var
  ICount: integer;
  AComponent: TComponent;
begin
  // broadcast a message to all associated components...
  if (MessagesEnabled) then
  begin
    for ICount := 0 to FRegisteredComponents.Count-1 do
    begin
      AComponent := TComponent(FRegisteredComponents[ICount]);
      if (AComponent is TWinControl) then
        PostMessage((AComponent as TWinControl).Handle, AMessage, Param1, Param2);
    end;
  end;
end;

procedure TGmPreview.PageSizeChanged(Sender: TObject);
begin
  FPaperSize := Custom;
  //FPages.PageWidth :=
  UpdatePreview;
end;

procedure TGmPreview.HeaderFooterChanged(Sender: TObject);
begin
  FPages.UpdateAll;
  UpdatePreview;
end;

procedure TGmPreview.PageChanged;
begin
  if Assigned(FOnPageChange) then FOnPageChange(Self, FCurrentPage);
  MessageToControls(GM_PAGE_CHANGED, 0, 0);
end;

procedure TGmPreview.SetCoordsRelative(const AValue: TGmCoordsRelative);
begin
  if AValue <> FCoordsRelativeTo then
  begin
    FCoordsRelativeTo := AValue;
    case AValue of
      fromPage          : FCanvas.SetDrawingOffset(0,0);
      fromPrinterMargins: FCanvas.SetDrawingOffset(FPrinter.PrinterMargins.Left.AsInches,
                                                   FPrinter.PrinterMargins.Top.AsInches);
      fromUserMargins   : FCanvas.SetDrawingOffset(FMargins.Left.AsInches,
                                                   FMargins.Top.AsInches);
      fromHeaderLine    : FCanvas.SetDrawingOffset(FMargins.Left.AsInches,
                                                   FMargins.Top.AsInches + FHeader.Height.AsInches);
    end;
  end;
end;

procedure TGmPreview.SetCurrentPage(AValue: integer);
begin
  if (FCurrentPage <> AValue) or (AValue = -1) then
  begin
    if Assigned(FOnPageChanging) then FOnPageChanging(Self, FCurrentPage);
    if AValue <> -1 then FCurrentPage := AValue;
    FCanvas.Page := FPages[FCurrentPage];
    UpdatePreview;
    PageChanged;
  end;
end;

procedure TGmPreview.SetGutter(AValue: integer);
begin
  if FGutter <> AValue then
  begin
    FGutter := AValue;
    FPaperImage.Gutter := AValue;
    UpdatePreview;
  end;
end;

procedure TGmPreview.SetMaxZoom(const AValue: integer);
begin
  if AValue = FMaxZoom then Exit;
  if AValue > FMinZoom then
    FMaxZoom := AValue
  else
    FMaxZoom := FMinZoom;
end;

procedure TGmPreview.SetMessagesEnabled(const AValue: Boolean);
begin
  if AValue then Dec(FUpdateCount) else Inc(FUpdateCount);
end;

procedure TGmPreview.SetMinZoom(const AValue: integer);
begin
  if AValue = FMinZoom then Exit;
  if AValue < FMaxZoom then
    FMinZoom := AValue
  else
    FMinZoom := FMaxZoom;
end;

procedure TGmPreview.SetOrientation(AValue: TGmOrientation);
var
  SavePaperSize: TGmPaperSize;
begin
  if AValue <> FOrientation then
  begin
    SavePaperSize := FPaperSize;
    try
      FOrientation := AValue;
      FPages.Orientation := FOrientation;
    finally
      FPaperSize := SavePaperSize;
      MessageToControls(GM_ORIENTATION_CHANGED, 0, 0);
      if Assigned(FOnChangeOrientation) then FOnChangeOrientation(Self);
    end;
  end;
end;

procedure TGmPreview.SetPagesPerSheet(AValue: TGmPagesPerSheet);
begin
  if FPagesPerSheet <> AValue then
  begin
    FPagesPerSheet := AValue;
    MessageToControls(GM_MULTIPAGE_CHANGED, 0, 0);
  end;
end;

procedure TGmPreview.SetPaperSize(AValue: TGmPaperSize);
var
  ASize: TGmSize;
begin
  try
    if AValue = Custom then Exit;
    if (FPaperSize <> AValue) then
    begin
      ASize := GetPaperDimensions(AValue);
      //FPages.PageHeight.AsInches := ASize.Height;
      //FPages.PageWidth.AsInches := ASize.Width;
      FPages.PaperSize := AValue;
    end;
  finally
    FPaperSize := AValue;
    if Assigned(FOnPageSizeChange) then FOnPageSizeChange(Self);
  end;
end;

procedure TGmPreview.SetPrintCopies(AValue: integer);
begin
  FPrinter.PrintCopies := AValue;
end;

procedure TGmPreview.SetTitle(ATitle: string);
begin
  GmPrinter.Title := ATitle;
end;

procedure TGmPreview.SetZoom(AValue: integer);
begin
  if AValue < 5 then AValue := 5;
  if FZoom <> AValue then
  begin
    FZoom := AValue;
    UpdatePreview;
  end;
end;

procedure TGmPreview.CanvasChanged(Sender: TObject);
begin
  if Assigned(FOnCanvasChange) then FOnCanvasChange(Self);
end;

procedure TGmPreview.MarginsChanged(Sender: TObject);
begin
  if Assigned(FOnMarginsChange) then FOnMarginsChange(Self);
end;

procedure TGmPreview.PrinterChanged(Sender: TObject);
begin
  MessageToControls(GM_PRINTER_CHANGED, 0, 0);
  if Assigned(FOnChangePrinter) then FOnChangePrinter(Self);
end;

procedure TGmPreview.PageOrientationChanged(Sender: TObject; APageNum: integer; AOrientation: TGmOrientation);
begin
  if Assigned(FOnChangePageOrientation) then FOnChangePageOrientation(Sender, APageNum, AOrientation);
end;

procedure TGmPreview.UpdatePreview;
var
  ATop, ALeft: integer;
  SX, SY: integer;
  PW, PH: integer;
  PageChanged: Boolean;
begin
  if IsUpdating then Exit;
  PageChanged := Pages[FCurrentPage].RedrawPage;
  FPaperImage.Page := Pages[FCurrentPage];
  SX := HorzScrollBar.Position;
  SY := VertScrollBar.Position;
  ATop := 0;
  ALeft := 0;
  FPaperImage.Zoom := FZoom;
  FPaperImage.PaperSize := FPaperSize;
  PW := Round(GetScale * (Pages[FCurrentPage].PageSize.Width.AsInches * SCREEN_PPI));
  PH := Round(GetScale * (Pages[FCurrentPage].PageSize.Height.AsInches * SCREEN_PPI));
  if (PW + (2*FGutter)) < Width then ALeft := (Width div 2)  - ((PW + (2*FGutter)) div 2);
  if (PH + (2*FGutter)) < Height then ATop := (Height div 2) - ((PH + (2*FGutter)) div 2);
  FPaperImage.SetBounds(ALeft-SX, ATop-SY, PW + (2*FGutter), PH + (2*FGutter));
  Invalidate;
  if PageChanged then MessageToControls(GM_PREVIEW_UPDATED, 0, 0);
end;

procedure TGmPreview.UsePrinterPageSize;
begin
  BeginUpdate;
  try
    Orientation := AsGmOrientation(GmPrinter.Orientation);
    PageHeight.AsInches := GmPrinter.PrinterHeight.AsInches;
    PageWidth.AsInches  := GmPrinter.PrinterWidth.AsInches;
    FPaperSize := GmPrinter.PrinterPaperSize;
  finally
    EndUpdate;
  end;
end;

procedure TGmPreview.ZoomIn;
var
  APercents: TGmPoint;
begin
  // zoom in...
  if FMouseOver then SetCursor(gmZoomIn);
  APercents := GetScrollbarPercents;
  case FZoomStyle of
    gmFixedZoom   : Zoom := Zoom + FZoomIncrement;
    gmVariableZoom: Zoom := Zoom + (Zoom div 2);
  end;
  ScrollToPosition(APercents.x, APercents.y);
end;

procedure TGmPreview.ZoomOut;
var
  APercents: TGmPoint;
begin
  // zoom out...
  if FMouseOver then SetCursor(gmZoomOut);
  APercents := GetScrollbarPercents;
  case FZoomStyle of
    gmFixedZoom   : Zoom := Zoom - FZoomIncrement;
    gmVariableZoom: Zoom := Zoom - (Zoom div 2);
  end;
  ScrollToPosition(APercents.x, APercents.y);
end;

//------------------------------------------------------------------------------

// *** Protected functions ***

procedure TGmPreview.CMMouseEnter (var Message: TMessage);
begin
  FMouseOver := True;
end;

procedure TGmPreview.CMMouseLeave (var Message: TMessage);
begin
  // stop panning when the mouse leaves the preview...
  FMouseOver := False;
  if FPanning then StopPanning;
end;

procedure TGmPreview.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TGmPreview.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(Sender, Button, Shift, X + FPaperImage.Left, Y + FPaperImage.Top);
end;

procedure TGmPreview.DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  MouseMove(Shift, X + FPaperImage.Left, Y + FPaperImage.Top);
  if Assigned(OnMouseMove) then
    OnMouseMove(Sender, Shift, X + FPaperImage.Left, Y + FPaperImage.Top);
end;

procedure TGmPreview.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Assigned(OnMouseUp) then
    OnMouseUp(Sender, Button, Shift, X + FPaperImage.Left, Y + FPaperImage.Top);
end;

procedure TGmPreview.DoPageDragDrop(Sender, Source: TObject; X, Y: TGmValue);
begin
  if Assigned(FOnPageDragDrop) then FOnPageDragDrop(Self, Source, X, Y);
end;

procedure TGmPreview.DoPageDragOver(Sender, Source: TObject; X, Y: TGmValue; State: TDragState; var Accept: Boolean);
begin
  if Assigned(FOnPageDragOver) then FOnPageDragOver(Self, Source, X, Y, State, Accept);
end;

procedure TGmPreview.DoPageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: TGmValue);
begin
  if Assigned(FOnPageMouseDown) then FOnPageMouseDown(Self, Button, Shift, X, Y);
end;

procedure TGmPreview.DoPageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: TGmValue);
begin
  if Assigned(FOnPageMouseMove) then FOnPageMouseMove(Self, Shift, X, Y);
end;

procedure TGmPreview.DoPageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: TGmValue);
begin
  if Assigned(FOnPageMouseUp) then FOnPageMouseUp(Self, Button, Shift, X, Y);
end;

procedure TGmPreview.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  // scroll the page (panning) if this option is selected...
  FMousePos.X := X;
  FMousePos.Y := Y;
  if FPanning then
  begin
    HorzScrollBar.Position := FPanningXYStart.X - FMousePos.X;
    VertScrollBar.Position := FPanningXYStart.Y - FMousePos.Y;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TGmPreview.PreviewResize(var Message: TMessage);
begin
  inherited;
  UpdatePreview;
end;   

procedure TGmPreview.WMNCHitTest(var Message: TMessage);
begin
  DefaultHandler(Message);
end;

procedure TGmPreview.ChangeDrawingDpi(var Message: TMessage);
begin
  DRAWING_DPI := Message.WParam;
end;

procedure TGmPreview.DefaultDrawingDpi(var Message: TMessage);
begin
  DRAWING_DPI := DEFAULT_DRAW_DPI;
end;

//------------------------------------------------------------------------------

// *** Public functions ***

function TGmPreview.GetFileVersion(AFileName: string): Extended;
var
  AStream: TFileStream;
begin
  // return the version of a TGmPreview which created the file referenced by
  // the AFileName paramater...
  Result := -1;
  AStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    try
      AStream.Read(Result, SizeOf(Result));
    except
      ShowGmError(Self, CANT_READ_VERSION);
    end;
  finally
    AStream.Free;
  end;
end;

function TGmPreview.NewPage: TGmPage;
begin
  Result := FPages.AddPage;
  FCanvas.Page := Result;
  if IsUpdating = False then LastPage;
  FCurrentPage := NumPages;
  if Assigned(FOnNewPage) then FOnNewPage(Self);
  MessageToControls(GM_NUMPAGES_CHANGED, 0, 0);
end;

function TGmPreview.PaperSizeToStr(APaperSize: TGmPaperSize): string;
begin
  case APaperSize of
    A3    : Result := C_A3;
    A4    : Result := C_A4;
    A5    : Result := C_A5;
    A6    : Result := C_A6;
    B5    : Result := C_B5;
    C5    : Result := C_C5;
    Legal : Result := C_Legal;
    Letter: Result := C_Letter;
  else
    Result := C_CUSTOM;
  end;
end;

function TGmPreview.Tokenize(AText: string; APage: integer): string;
var
  tokenPosition: integer;
begin
  Result := AText;
  // search and replace the {DATE} token...
  while Pos('{DATE}', Result) <> 0 do
  begin
    tokenPosition := Pos('{DATE}', Result);
    Delete(Result, tokenPosition, 6);
    Insert(FormatDateTime('dd-mmm-yyyy',Date), Result, tokenPosition);
  end;

  // search and replace the {TIME} token...
  while Pos('{TIME}', Result) <> 0 do
  begin
    tokenPosition := Pos('{TIME}', Result);
    Delete(Result, tokenPosition, 6);
    Insert(FormatDateTime('hh:nn',Time), Result, tokenPosition);
  end;

  // search and replace the {PAGE} token...
  while Pos('{PAGE}', Result) <> 0 do
  begin
    tokenPosition := Pos('{PAGE}', Result);
    Delete(Result, tokenPosition, 6);
    Insert(IntToStr(APage), Result, tokenPosition);
  end;

  // search and replace the {NUMPAGES} token...
  while Pos('{NUMPAGES}', Result) <> 0 do
  begin
    tokenPosition := Pos('{NUMPAGES}', Result);
    Delete(Result, tokenPosition, 10);
    Insert(IntToStr(NumPages), Result, tokenPosition);
  end;
end;

procedure TGmPreview.AddAssociatedComponent(AComponent: TComponent);
begin
  if FRegisteredComponents.IndexOf(AComponent) = -1 then
    FRegisteredComponents.Add(AComponent);
end;

procedure TGmPreview.RemoveAssociatedComponent(AComponent: TComponent);
begin
  if FRegisteredComponents.IndexOf(AComponent) <> -1 then
    FRegisteredComponents.Delete(FRegisteredComponents.IndexOf(AComponent));
end;

procedure TGmPreview.Assign(Source: TPersistent);
var
  APreview: TGmPreview;
begin
  // assign all objects and properties...
  APreview := (Source as TGmPreview);
  Dec(FUpdateCount);
  try
    FHeader.Assign(APreview.FHeader);
    FFooter.Assign(APreview.FFooter);
    FMargins.Assign(APreview.FMargins);
    FPrinter.Assign(APreview.FPrinter);
    FPaperSize := APreview.FPaperSize;
    FOrientation := APreview.FOrientation;
    FPages.Assign(APreview.FPages);
    FPagesPerSheet := APreview.FPagesPerSheet;
    FShadow.Assign(APreview.FShadow);
    PageWidth.Assign(APreview.PageWidth);
    PageHeight.Assign(APreview.PageHeight);
    FCurrentPage := -1;
  finally
    Inc(FUpdateCount);
    CurrentPage := APreview.CurrentPage;
  end;
end;

procedure TGmPreview.BeginUpdate;
begin
  Inc(FUpdateCount);
  FTempInt := NumPages;
  FPaperImage.Enabled := False;
  ForceMessageToControls(GM_PREVIEW_BEGINUPDATE, 0, 0);
end;

procedure TGmPreview.CenterOnClick(x, y: integer);
begin
  ShowGmMessage(Self, '"TGmPreview.CenterOnClick"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmPreview.Clear;
var
  ICount: integer;
begin
  FCurrentPage := 1;
  for ICount := FPages.Count downto 1 do
  begin
    if ICount > 1 then FPages.DeletePage(ICount)
    else
      FPages.Page[ICount].Clear;
  end;
  FCanvas.Page := Pages[FCurrentPage];
  UpdatePreview;
  if Assigned(FOnClear) then FOnClear(Self);
  MessageToControls(GM_PREVIEW_CLEARED, 0, 0);
end;

procedure TGmPreview.DeleteCurrentPage;
begin
  DeletePage(FCurrentPage);
  UpdatePreview;
end;

procedure TGmPreview.DeletePage(index: integer);
begin
  if (CurrentPage = NumPages) and (NumPages > 1) then
  begin
    FCurrentPage := FCurrentPage-1;
  end;
  if (index = 1) and (NumPages = 1) then
    FPages[index].Clear
  else
    FPages.DeletePage(index);
  SetCurrentPage(-1);
  MessageToControls(GM_NUMPAGES_CHANGED, 0, 0);
  if Assigned(FOnDeletePage) then FOnDeletePage(Self);
end;

procedure TGmPreview.EndUpdate;
begin
  Dec(FUpdateCount);
  if not IsUpdating then
  begin
    FPaperImage.Enabled := True;
    UpdatePreview;
    ForceMessageToControls(GM_PREVIEW_ENDUPDATE, 0, 0);
  end;
  if FTempInt <> NumPages then PageChanged;
end;

procedure TGmPreview.FindText(AText: string; CaseSensative: Boolean; AList: TList);
begin
    ShowGmMessage(Self, '"TGmPreview.FindText"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmPreview.FirstPage;
begin
  if CurrentPage > 1 then
    CurrentPage := 1;
end;

procedure TGmPreview.FitHeight;
begin
  ShowGmMessage(Self, '"TGmPreview.FitHeight"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmPreview.FitWidth;
begin
  ShowGmMessage(Self, '"TGmPreview.FitWidth"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmPreview.FitWholePage;
begin
  ShowGmMessage(Self, '"TGmPreview.FitWholePage"'+#13+#13+PRO_VERSION_ONLY);

end;

procedure TGmPreview.LastPage;
begin
  if CurrentPage < NumPages then
    CurrentPage := NumPages;
end;

procedure TGmPreview.LoadFromStream(AStream: TStream);
var
  AFileVersion: Extended;
  GmStream: TGmExtStream;
  ICount: integer;
  LoadFile: Boolean;
  ANumberPages: integer;
begin
  // load the TGmPreview from a Stream...
  BeginUpdate;
  AStream.ReadBuffer(AFileVersion, SizeOf(AFileVersion));
  GmStream := TGmExtStream.Create;
  try
    Clear;
    if Assigned(FBeforeReadStream) then FBeforeReadStream(Self, GmStream);
    GmStream.LoadFromStream(AStream);
    LoadFile := True;
    if Assigned(FBeforeLoad) then FBeforeLoad(Self, AFileVersion, LoadFile);
    if LoadFile = False then Exit;
    LoadDocInfoFromStream(GmStream, ANumberPages);
    LoadPageSetupFromStream(GmStream);
    Margins.LoadFromStream(GmStream);
    FHeader.LoadFromStream(GmStream);
    Footer.LoadFromStream(GmStream);

    for ICount := 1 to ANumberPages do
      if ICount <> 1 then NewPage;
      // now load the pages...
    for ICount := 1 to ANumberPages do
    begin
      Pages[ICount].LoadFromStream(AFileVersion, GmStream);
      if Assigned(FOnLoadProgress) then FOnLoadProgress(Self, (ICount/NumPages)*100);
    end;
  finally
    GmStream.Free;
    EndUpdate;
  end;
end;

procedure TGmPreview.LoadFromFile(AFilename: string);
var
  AFileStream: TFileStream;
  AFileVersion: Extended;
begin
  // load a TGmPreview file...
  AFileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    AFileStream.Read(AFileVersion, SizeOf(AFileVersion));
    AFileStream.Seek(0, soFromBeginning);
    LoadFromStream(AFileStream);
  finally
    AFileStream.Free;
  end;
end;

procedure TGmPreview.NextPage;
begin
  if CurrentPage < NumPages then
    CurrentPage := CurrentPage + 1;
end;

procedure TGmPreview.PrevPage;
begin
  if CurrentPage > 1 then
    CurrentPage := CurrentPage -1;
end;

procedure TGmPreview.Print;
begin
  PrintRange(1, NumPages);
end;

procedure TGmPreview.PrintCurrentPage;
begin
  PrintRange(FCurrentPage, FCurrentPage);
end;

procedure TGmPreview.PrintRange(APageFrom, APageTo: integer);
var
  APage: TGmPage;
  ICount: integer;
  AStartPage,
  AEndPage: integer;
  ACopies: integer;
begin
  if Assigned(FPrinter.PrintDialog) then ;


  if GetOrientationType = gmMixedOrientation then
    FPrinter.PagesPerSheet := gmOnePage
  else
    FPrinter.PagesPerSheet := FPagesPerSheet;

  FPrinter.Orientation := AsPrinterOrientation(FPages[1].Orientation);

  if Assigned(FBeforePrint) then FBeforePrint(Self);


  FPrinter.BeginDoc;

  if not FPrinter.Printing then Exit;
  try
    if FReversePrintOrder then
    begin
      AStartPage := APageTo;
      AEndPage := APageFrom-1;
    end
    else
    begin
      AStartPage := APageFrom;
      AEndPage := APageTo+1;
    end;
    
    for ACopies := 1 to PrintCopies do
    begin
      ICount := AStartPage;
      while (ICount <> AEndPage) do
      begin
        APage := Pages[ICount];
        if Assigned(FBeforePrintPage) then FBeforePrintPage(Self, APage, FPrinter.Handle);
        if Assigned(FOnPrintPage) then FOnPrintPage(Self, APage, FPrinter.Handle);
        APage.Print(FPrinter);

        if Assigned(FAfterPrintPage) then FAfterPrintPage(Self, APage, FPrinter.Handle);

        if ICount < APageTo then
          FPrinter.NewPage(Pages[ICount+1].Orientation);
        Application.ProcessMessages;
        if FPrinter.Aborted then Exit;
        if Assigned(FOnPrintProgress) then FOnPrintProgress(Self, ICount, (APageTo - APageFrom));

        if FReversePrintOrder then Dec(ICount) else Inc(ICount);
        if (ICount < 1) or (ICount > NumPages) then Exit;
      end;
    end;
  finally
    if not FPrinter.Aborted then
    begin
      FPrinter.EndDoc;
      if Assigned(FAfterPrint) then FAfterPrint(Self);
    end
    else
      if Assigned(FOnAbortPrint) then FOnAbortPrint(Self);
  end;
end;

procedure TGmPreview.PrintToFile(AFileName: string);
begin
  FPrinter.FileName := AFileName;
  try
    Print;
  finally
    FPrinter.FileName := '';
  end;
end;

procedure TGmPreview.SaveDocInfoToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  GmStream := TGmExtStream.Create;
  try
    // the two following values aren't used yet... but I thought they may be
    // needed at a later time.
    GmStream.WriteDateTime(Now);
    GmStream.WriteInteger(NumPages);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmPreview.SavePageSetupToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(FPages.PageWidth.AsUnits);
    GmStream.WriteInteger(FPages.PageHeight.AsUnits);
    GmStream.WriteStr(PaperSizeToStr(FPaperSize));
    GmStream.WriteInteger(Ord(Orientation));
    GmStream.WriteInteger(Shadow.Color);
    GmStream.WriteInteger(Shadow.Width);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmPreview.SaveToFile(AFilename: string);
var
  AFileStream: TFileStream;
begin
  // Save the TGmPreview pages to a file...
  AFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AFileStream);
  finally
    AFileStream.Free;
  end;
end;

procedure TGmPreview.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
  ICount: integer;
  AVersion: Extended;
begin
  // Save the TGmPreview to a stream...
  AVersion := SUITE_VERSION;
  AStream.WriteBuffer(AVersion, SizeOf(AVersion));
  GmStream := TGmExtStream.Create;
  try
    SaveDocInfoToStream(GmStream);
    SavePageSetupToStream(GmStream);
    Margins.SaveToStream(GmStream);

    FHeader.SaveToStream(GmStream);
    FFooter.SaveToStream(GmStream);
    for ICount := 1 to NumPages do
    begin
      FPages.Page[ICount].SaveToStream(GmStream);
      if Assigned(FOnSaveProgress) then FOnSaveProgress(Self, (ICount/NumPages)*100);
    end;
  finally
    if Assigned(FBeforeWriteStream) then FBeforeWriteStream(Self, GmStream);
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmPreview.ScrollToPosition(XPercent, YPercent: Extended);
begin
  HorzScrollBar.Position := Round((XPercent/100) * (HorzScrollBar.Range-ClientWidth));
  VertScrollBar.Position := Round((YPercent/100) * (VertScrollBar.Range-ClientHeight));
end;

procedure TGmPreview.SetCursor(ACursor: TGmCursor);
begin
  // change the preview page cursor...
  case ACursor of
    gmDefault   : Cursor := crDefault;
    gmZoomIn    : Cursor := crZoomIn;
    gmZoomOut   : Cursor := crZoomOut;
  end;
end;

procedure TGmPreview.SetPageSize(AWidth, AHeight: Extended; AUnits: TGmMeasurement);
begin
  PageHeight.AsGmValue[AUnits] := AHeight;
  PageWidth.AsGmValue[AUnits] := AWidth;
end;

procedure TGmPreview.StartPanning;
begin
  // start the panning of the page...
  ShowGmMessage(Self, '"TGmPreview.StartPanning"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmPreview.StopPanning;
begin
  // stop the page panning...
  ShowGmMessage(Self, '"TGmPreview.FitWidth"'+#13+#13+PRO_VERSION_ONLY);
end;

end.
