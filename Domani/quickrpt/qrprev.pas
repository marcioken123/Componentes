{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::                                               
  ::                                                         ::
  :: QRPREV.PAS - QUICKREPORT STANDARD PREVIEW FORM          ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: http://www.qusoft.com                                   ::
  :: 5/12/2003  new preview for 4                            ::
  :: 24/03/2005  duplex fixed when PrintMetafileFrom= true   ::
  :: 3/8/05   added page jump to search tab                  ::
  :: 6/9/05   restored AfterPrint event for metafile print   ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QRPrev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, QRPrntr, QR4const, QRExtra, ComCtrls, ToolWin,
  Menus , ImgList, Grids, printers;

type
  TQRStandardPreview = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ZoomFit: TToolButton;
    Zoom100: TToolButton;
    ZoomToWidth: TToolButton;
    FirstPage: TToolButton;
    PreviousPage: TToolButton;
    nextPage: TToolButton;
    LastPage: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    SaveReport: TToolButton;
    LoadReport: TToolButton;
    Images: TImageList;
    ToolButton1: TToolButton;
    ExitButton: TSpeedButton;
    QRPreview: TQRPreview;
    Splitter1: TSplitter;
    Spacer2: TToolButton;
    Tabs: TPageControl;
    TabThumbs: TTabSheet;
    TabSearchResult: TTabSheet;
    Splitter2: TSplitter;
    GroupBox1: TGroupBox;
    SearchResultBox: TListBox;
    SearchTextLabel: TLabel;
    ThumbGrid: TDrawGrid;
    Spacer3: TToolButton;
    Spacer4: TToolButton;
    FindButton: TToolButton;
    Spacer1: TToolButton;
    GotoPageButton: TToolButton;
    Spacer5: TToolButton;
    PrintDialog1: TPrintDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomToFitClick(Sender: TObject);
    procedure ZoomTo100Click(Sender: TObject);
    procedure ZoomToWidthClick(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormCreate(Sender: TObject);
    procedure QRPreviewHyperlink(Sender: TObject; EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
    procedure OutlineViewChange(Sender: TObject; Node: TTreeNode);
    procedure ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
    procedure ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure GotoPageButtonClick(Sender: TObject);
    procedure SearchResultBoxClick(Sender: TObject);
  protected
    procedure WndProc( var Message : TMessage ); override;
  private
    FQRPrinter : TQRPrinter;
    FReportOrientation : TPrinterOrientation;
    Gauge : TProgressBar;
    LastProgress : integer;
    ThumbFontHeight,
    ThumbDrawHeight,
    ThumbDrawWidth,
    ThumbTopMargin,
    ThumbLeftMargin : integer;
    ShowThumbs, ShowSearch : boolean;
    InitZoom : TQRZoomstate;
  public
    constructor CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter); virtual;
    procedure Show;
    procedure UpdateInfo;
    procedure SelectPage(aPageNumber : integer);
    procedure ResizeThumb(Sender : TObject);
    function GetTextSearch(var MatchCase : boolean; var AText : string) : boolean;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
  end;

  TResizeGrid = class(TDrawGrid)
  public
    property OnResize;
  end;

implementation

uses
   qrsearchdlg, quickrpt;
   var
      ThumbUpdating, ThumbSelecting : boolean;
      ReportTitle : string;
//  QRSearch;
{$R *.DFM}

procedure TQRStandardPreview.WndProc( var Message : TMessage );
var
   i : integer;
begin
   if Message.Msg = WM_MOUSEWHEEL then
   begin
     Message.Msg := WM_KEYDOWN;
     Message.lParam := 0;
     i := HiWord(Message.wParam) ;
     if i > 0 then
       Message.wParam := VK_UP
     else
       Message.wParam := VK_DOWN;
   end;
   inherited WndProc( message );
end;

// amended procedure - if initZoom is Other, then the zoom factor is
// set to the quickreps design Zoom property.
constructor TQRStandardPreview.CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter);
var
     localZoom : integer;//ZOOM FIX
begin
  inherited Create(AOwner);
  // set captions
  tabs.Pages[0].Caption := sqrThumbNails;
  tabs.Pages[1].Caption := sqrSearchResults;
  groupbox1.Caption := sqrSearchText;
  zoomfit.Hint := SqrZoomToFit;
  zoomTowidth.Hint := sqrZoomTowidth;
  zoom100.Hint := sqrZoom100;
  firstpage.Hint := sqrFirstPage;
  nextpage.Hint := sqrNextPage;
  previouspage.Hint := sqrPrevPage;
  lastpage.Hint := sqrLastPage;
  gotoPagebutton.Hint := sqrPageSelect;
  findButton.Hint := sqrFindCaption;
  printSetup.Hint := sqrPrinterSetup;
  print.Hint := sqrPrint;
  saveReport.Hint := sqrSaveReport;
  loadReport.Hint := sqrLoadReport;
  exitButton.Hint := sqrClosePreview;
  caption := sqrPreviewWindowCaption;
  exitbutton.caption := sqrExitButtonCaption;


  QRPrinter := aQRPrinter;
  if qrprinter.parentreport is TCustomquickrep then
  begin
     FormStyle := TCustomquickrep(qrprinter.ParentReport).PrevFormstyle;
     width := TCustomquickrep(qrprinter.ParentReport).PreviewWidth;
     height := TCustomquickrep(qrprinter.ParentReport).Previewheight;
     WindowState := TCustomquickrep(qrprinter.ParentReport).PreviewInitialState;
     ShowThumbs := TCustomquickrep(qrprinter.ParentReport).PrevShowThumbs;
     ShowSearch := TCustomquickrep(qrprinter.ParentReport).PrevShowSearch;
     InitZoom := TCustomquickrep(qrprinter.ParentReport).PrevInitialZoom;
     reportTitle := TCustomquickrep(qrprinter.ParentReport).ReportTitle;
     QRPrinter.Title := reportTitle;
     FReportOrientation := TCustomquickrep(qrprinter.ParentReport).Page.Orientation;
     localZoom := TCustomquickrep(qrprinter.ParentReport).zoom; // ZOOM FIX
  end
  else
  begin // this should never happen
     WindowState := wsMaximized;
     ShowThumbs := true;
     ShowSearch := true;
     localZoom := 100; // ZOOM FIX
  end;
  QRPreview.QRPrinter := aQRPrinter;
  QRPreview.QRPrinter.Orientation := FReportOrientation;
  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then Caption := sqrPreviewWindowCaption + QRPrinter.Title;
  Gauge := TProgressBar.Create(Self);
  Gauge.Top := 2;
  Gauge.Left := 2;
  Gauge.Height := 10;
  Gauge.Width := 100;
  LastProgress := 0;
  // qrprinter.load -> qrprinter.preview grid bug fix
  ThumbGrid.RowCount := 1; // ******************
  Tabs.Visible := ShowThumbs or ShowSearch;
  try
     if Tabs.Visible and (QRPrinter.PageCount > 0) then
         ThumbGrid.RowCount := QRPrinter.PageCount;

     if Tabs.Visible then TabThumbs.TabVisible := ShowThumbs;
     findButton.visible := ShowSearch;
     if not ShowSearch and Tabs.Visible then
     begin
        TabSearchResult.TabVisible := false;
        findButton.Visible := false;
     end;
  except

  end;
  if InitZoom = QRZoomtofit then
  begin
      QRPreview.ZoomToFit ;
      ZoomFit.Down := true;
  end
  else if InitZoom = QRZoomtowidth then
  begin
      QRPreview.ZoomToWidth;
      ZoomToWidth.Down := true;
  end
  else
  begin
      QRPreview.Zoom := localZoom;// ZOOM FIX
      QRPreview.UpdateZoom;
      Zoom100.Down := true;
  end;
  if qrprinter.status = mpFinished then
    Print.Enabled := true;
end;

procedure TQRStandardPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qrprinter.Status = mpBusy then
  begin
       Action := caNone;
       exit;
  end;
  QRPrinter.ClosePreview(Self);
  application.ProcessMessages;
  Action := caFree;
end;

procedure TQRStandardPreview.UpdateInfo;
begin
  StatusBar.Panels[1].Text := SqrPage + ' ' + IntToStr(QRPreview.PageNumber) + ' ' +
    SqrOf + ' ' + IntToStr(QRPreview.QRPrinter.PageCount);

  StatusBar.Panels[2].Text := ReportTitle;

end;

procedure TQRStandardPreview.ZoomToFitClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToFit;
end;

procedure TQRStandardPreview.ZoomTo100Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.Zoom := 100;
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.ZoomToWidthClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToWidth;
end;

procedure TQRStandardPreview.SelectPage(aPageNumber : integer);
begin
  QRPreview.PageNumber := APageNumber;
  UpdateInfo;
  // set thumb row
  if ((aPagenumber > 0) and ( aPagenumber <= QRPrinter.PageCount) and (aPagenumber <= ThumbGrid.RowCount)) then
  begin
     ThumbUpdating := true;
     ThumbGrid.Row := APageNumber-1;
     ThumbUpdating := false;
  end;
end;

procedure TQRStandardPreview.FirstPageClick(Sender: TObject);
begin
  SelectPage(1)
end;

procedure TQRStandardPreview.PrevPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber - 1);
end;

procedure TQRStandardPreview.NextPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber + 1);
end;

procedure TQRStandardPreview.LastPageClick(Sender: TObject);
begin
  if (qrprinter.status = mpFinished) then    
  begin
     SelectPage(QRPrinter.PageCount);
  end
  else
  begin
     SelectPage(QRPrinter.PageCount - 1);
  end
end;

procedure TQRStandardPreview.PrintClick(Sender: TObject);
begin
      if PrintMetafileFromPreview or ( not (qrprinter.ParentReport is TQuickRep)) then
           QRPrinter.Print
      else
           TQuickRep( qrprinter.ParentReport).print;
end;

procedure TQRStandardPreview.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TQRStandardPreview.FormResize(Sender: TObject);
begin
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.Show;
begin
  inherited Show;
  UpdateInfo;
end;

procedure TQRStandardPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_Next : if Shift = [ssCtrl] then
                LastPageClick(Self)
              else
                NextPageClick(Self);
    VK_Prior : if Shift = [ssCtrl] then
                 FirstPageClick(Self)
               else
                 PrevPageClick(Self);
    VK_Home : FirstPageClick(Self);
    VK_End : LastPageClick(Self);
    VK_Escape : ExitClick(self);
    vk_down :
    begin
      if ((QRPreview.VertScrollBar.Position + QRPreview.VertScrollBar.Increment)<(QRPreview.VertScrollBar.Range - QRPreview.Height)) then
        QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position + QRPreview.VertScrollBar.Increment
      else
      begin
        ThumbSelecting := true;
        NextPageClick(Self);
        ThumbSelecting := false;
      end;
    end;
    vk_up :
    begin
      if (QRPreview.VertScrollBar.Position-QRPreview.VertScrollBar.Increment)>0 then
        QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position - QRPreview.VertScrollBar.Increment
      else
      begin
        ThumbSelecting := true;
        PrevPageClick(Self);
        ThumbSelecting := false;
        QRPreview.VertScrollBar.Position := (QRPreview.VertScrollBar.Range - QRPreview.Height) - QRPreview.VertScrollBar.Increment;
      end;
    end;
  end;
end;

procedure TQRStandardPreview.SaveClick(Sender: TObject);
var
  aExportFilter : TQRExportFilter;
begin
  aExportFilter := nil;
  with TSaveDialog.Create(Application) do
  try
    Title := SqrSaveReport;
    Filter := QRExportFilterLibrary.SaveDialogFilterString;
    DefaultExt := cQRPDefaultExt;
    // next line is the new one
    Options := [ofOverwritePrompt];
    if Execute then
    begin
      if FilterIndex = 1 then
        QRPrinter.Save(Filename)
      else
      begin
        try
          aExportFilter := TQRExportFilterLibraryEntry(
            QRExportFilterLibrary.Filters[FilterIndex - 2]).ExportFilterClass.Create(Filename);
          QRPrinter.ExportToFilter(aExportFilter);
        finally
          aExportFilter.Free
        end
      end
    end;
  finally
    Free;
  end;
end;

procedure StandardSetup;
begin
end;

procedure TQRStandardPreview.PrintSetupClick(Sender: TObject);
var
   prep : TCustomquickrep;
begin
  printer.Refresh;
  if TCustomquickrep( qrprinter.ParentReport).ParentComposite <> nil then
  begin
       prep := TCustomquickrep( qrprinter.ParentReport);
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       // 8/02/05
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.PrinterIndex := prep.UserPrinterSettings.PrinterIndex;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.FirstPage :=
                                                    prep.UserPrinterSettings.FirstPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.LastPage :=
                                                    prep.UserPrinterSettings.LastPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       TQRCompositeReport( prep.ParentComposite).printerSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       QRPrinter.aPrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
       QRPrinter.aPrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
       exit;
  end;
  if qrprinter.ParentReport is TCustomquickrep then
  Begin
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       prep := TCustomquickrep( qrprinter.ParentReport);
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       QRPrinter.aPrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
       QRPrinter.aPrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
       if not PrintMetafileFromPreview then
       begin
           // set the quickrep settings
           prep.PrinterSettings.PrinterIndex := prep.UserPrinterSettings.PrinterIndex;
           prep.PrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
           prep.PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
           prep.PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
           prep.PrinterSettings.FirstPage := prep.UserPrinterSettings.FirstPage;
           prep.PrinterSettings.LastPage := prep.UserPrinterSettings.LastPage;
           prep.PrinterSettings.UseStandardprinter := prep.UserPrinterSettings.UseStandardprinter;
           prep.PrinterSettings.UseCustomBinCode := prep.UserPrinterSettings.UseCustomBinCode;
           prep.PrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
           prep.PrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
           prep.PrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
           prep.PrinterSettings.UseCustomPaperCode := prep.UserPrinterSettings.UseCustomPaperCode;
           prep.PrinterSettings.CustomPaperCode := prep.UserPrinterSettings.CustomPaperCode;
           prep.PrinterSettings.MemoryLimit := prep.UserPrinterSettings.MemoryLimit;
           prep.PrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
           prep.PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
           prep.PrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
           prep.PrinterSettings.Orientation := prep.UserPrinterSettings.Orientation;
           prep.PrinterSettings.PaperSize := prep.UserPrinterSettings.PaperSize;
       end;
  end;
end;

procedure TQRStandardPreview.LoadClick(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  try
    Title := SqrLoadReport;
    Filter := SqrQRFile + ' (*.' +cQRPDefaultExt + ')|*.' + cqrpDefaultExt;
    if Execute then
      if FileExists(FileName) then
      begin
        QRPrinter.Load(Filename);
        reportTitle := filename;
        QRPreview.PageNumber := 1;
        QRPreview.PreviewImage.PageNumber := 1;
        // fix orientation bug.
        FReportOrientation := QRPrinter.Orientation;
        qrpreview.UpdateZoom;
        // have to reset the thumbs with this call
        QRPreviewPageAvailable( self, 1);
        thumbGrid.Row := 0;
        //PrintSetup.Enabled := False;
        PrintMetafileFromPreview := true;
        Print.Enabled := true;
        SaveReport.Enabled := false;
        SaveReport.visible := false;
      end
      else
        ShowMessage(SqrFileNotExist);
  finally
    free;
  end;
end;

procedure TQRStandardPreview.QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
begin
  UpdateInfo;
  ThumbGrid.RowCount := QRPrinter.PageCount;
  ThumbGrid.Invalidate;
  if qrprinter.status = mpFinished then
  begin
    PrintSetup.Enabled := true;
    Print.Enabled := true;
    SaveReport.Enabled := true;
    LoadReport.Enabled := true;
 
    ThumbGrid.RowCount := QRPrinter.PageCount;
    Sleep(100);
  end
  else
    ThumbGrid.RowCount := QRPrinter.PageCount-1;

end;

procedure TQRStandardPreview.QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
begin
  if Progress >= LastProgress + 5 then
  begin
    StatusBar.Panels[0].Text := IntToStr(Progress)+'%';
    LastProgress := Progress;
  end;
  if (Progress = 0) or (Progress = 100) then StatusBar.Panels[0].Text := '';
end;

procedure TQRStandardPreview.FormCreate(Sender: TObject);
begin
   HorzScrollbar.Tracking := true;
   VertScrollbar.Tracking := true;
   TResizeGrid(ThumbGrid).OnResize := ResizeThumb;
end;

procedure TQRStandardPreview.QRPreviewHyperlink(Sender: TObject;
  EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
begin
  Statusbar.Panels[2].Text := Link;
end;

procedure TQRStandardPreview.OutlineViewChange(Sender: TObject; Node: TTreeNode);
var
  NewPage : integer;
  ARect : TRect;
begin
  QRPrinter.PageList.QROutline.FindPosition(Node, ARect, NewPage);
  if NewPage > 0 then
  begin
    QRPreview.PageNumber := NewPage;
    UpdateInfo;
  end;
end;

procedure TQRStandardPreview.ResizeThumb(Sender: TObject);
begin
  ThumbFontHeight := ThumbGrid.Canvas.TextHeight('P');
  ThumbGrid.DefaultColWidth := ThumbGrid.Width - 4;
  if FReportOrientation = poPortrait then
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperWidth) * QRPrinter.PaperLength - ThumbFontHeight);
  end
  else
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperLength) * QRPrinter.PaperWidth - ThumbFontHeight);
  end;

  ThumbGrid.DefaultRowHeight := ThumbDrawHeight;
  ThumbLeftMargin := Round((ThumbGrid.DefaultColWidth - ThumbDrawWidth) / 2);
  ThumbTopMargin := Round((ThumbGrid.DefaultRowHeight - ThumbDrawHeight) / 2);
end;

procedure TQRStandardPreview.ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  APage : TMetafile;
begin
  APage := QRPrinter.GetPage(ARow+1);
  if APage <> nil then
    PaintPageToCanvas(APage, ThumbGrid.Canvas, Rect(ARect.Left + ThumbLeftMargin, ARect.Top + 10,
                                 ARect.Right - 30, ARect.Bottom - 10), true);
  ThumbGrid.Canvas.Brush.Color := clBtnFace;
  ThumbGrid.Canvas.pen.Color := clblack;
  SetBkMode(ThumbGrid.Canvas.Handle, TRANSPARENT);
  ThumbGrid.Canvas.Textout(ARect.Left, ARect.Top, IntToStr(ARow + 1));
  SetBkMode(ThumbGrid.Canvas.Handle, OPAQUE);          
  APage.Free;
end;

procedure TQRStandardPreview.ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
     if ThumbUpdating or ThumbSelecting then exit;
     ThumbSelecting := true;
     if QRPreview.PageNumber <> (ARow + 1) then
                 QRPreview.PageNumber := ARow + 1;
     //sleep(100);
     UpdateInfo;
     Thumbselecting := false;
end;

function TQRStandardPreview.GetTextSearch(var MatchCase : boolean; var AText : string) :  boolean;
var
    SrchDlg : TSearchDlg;
begin
  AText := '';
  Result := false;
  SrchDlg := TSearchDlg.Create( self);
  srchDlg.ShowModal;
  if srchDlg.cancel then
  begin
       SrchDlg.Free;
       exit;
  end;
  Result := true;
  srchDlg.GetText( AText );
  MatchCase := srchDlg.GetCase;
  SrchDlg.Free;
end;

procedure TQRStandardPreview.FindButtonClick(Sender: TObject);
var
  FindStr : string;
  MatchCase : boolean;
  I : integer;
  APage : TMetafile;
begin
  if qrprinter.Status = mpBusy then exit;
  if GetTextSearch(MatchCase, FindStr) then
  begin
    SearchResultBox.Enabled := true;
    SearchTextLabel.Caption := FindStr;
    SearchResultBox.Items.Clear;
    for I := 1 to QRPrinter.PageCount do
    begin
       APage := QRPrinter.GetPage(I);
       try
           if StrInMetafile(FindStr, APage, MatchCase) then
             SearchResultBox.Items.AddObject(sqrPage+' ' + IntToStr(I),TObject(i));
       finally
         APage.Free;
       end;
    end;
    if SearchResultBox.Items.Count = 0 then
    begin
      SearchResultBox.Items.Add(sqrSearchNoResult);
      SearchResultBox.Enabled := false;
    end;
  end;
end;

procedure TQRStandardPreview.GotoPageButtonClick(Sender: TObject);
var
  Pnum, K : integer;
  PNStr : string;
  CaptionStr : string;
begin
  CaptionStr := format(SqrGotoPage, [QRPrinter.PageCount]);
  PNStr := format( '%d', [QRPreview.PageNumber]);
  InputQuery(CaptionStr, sqrGoPage, PNStr );
  val(PNStr, Pnum, K );
  if (Pnum < 1) or (Pnum > QRPrinter.PageCount) then
     Pnum := 1;
  SelectPage(Pnum );
end;

procedure TQRStandardPreview.SearchResultBoxClick(Sender: TObject);
var
   Page:Integer;
begin
  With SearchResultBox Do
    If ItemIndex>=0 Then
      Page:=Integer(Items.Objects[ItemIndex])
    Else
      Page:=1;
  if (Page < 1) or (Page > QRPrinter.PageCount) then
     Page := 1;
  SelectPage(Page );

end;

end.



