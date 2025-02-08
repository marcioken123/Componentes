unit ElXTreePrinter;
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

ElXTreePrinter unit
-------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  ImgList, Math, Windows, Graphics, StdCtrls, Controls, Types, SysUtils, Classes,
  ElXTree, ElXTreeCell, ElTreeInplaceEditors, ElPrinter, Forms, ElHeader, ElXHeader,
  ElStack, ElVCLUtils,
  LMDHTMLUnit, LMDTypes;

type
  TElXHeaderPrintSettings = class;
  TElXTreePrintSettings = class;

  TElXPrintTreeItemEvent = procedure(Sender : TObject; Item : TElXTreeItem; var Print : boolean) of object;
  TElXPrintHeaderSectionEvent = procedure(Sender : TObject; Section : TElXHeaderSection; var Print : boolean) of object;
  EElXTreePrinterError = class(Exception);

  TElXHeaderPrintOption = (hpoPrintOnEveryPage, hpoShowSortMarks, hpoShowImages, hpoWrapCaptions, hpoFlat);
  TElXHeaderPrintOptions = set of TElXHeaderPrintOption;
  TElXTreePrintOption =
    (tpoShowButtons,
     tpoShowEmptyImages,
     tpoShowEmptyImages2,
     tpoShowCheckboxes,
     tpoShowColumns,
     tpoShowHeader,
     tpoShowHiddenItems,
     tpoShowHiddenSections,
     tpoShowImages,
     tpoShowInvisibleItems,
     tpoShowInvisibleSections,
     tpoShowLines,
     tpoShowRoot,
     tpoShowRootButtons,
     tpoShowLeafButton,
     tpoShowVerticalLines,
     tpoShowHorizontalLines,
     tpoUseItemStyles,
     tpoUseCellStyles
     );

  TElXTreePrintOptions = set of TElXTreePrintOption;

  TElXTreePrinter = class(TElControlPrinter)
  private
    FOnAfterPage: TPageEvent;
    FOnBeforePage: TPageEvent;
    procedure SetTree(Value: TCustomElXTree);
    procedure SetTreeProps(ATree:TCustomElXtree);
    procedure SetHeaderPS(const Value: TElXHeaderPrintSettings);
    procedure SetTreePS(const Value: TElXTreePrintSettings);
    procedure SetPrintAsIs(const Value: boolean);
  protected
    FShowPageNumbers: Boolean;
    FPageNumbersLayout: TPNLayout;
    FPageNumbersText: TLMDString;
    FPageNumbersAlignment: TAlignment;
    FCaption: TLMDString;
    FOnDrawPageNumber: TDrawPageNumberEvent;
    FOnDrawCaption: TDrawPageCaptionEvent;
    FPrinting : boolean;
    FPrintAsIs: boolean;

    FRender : TLMDHTMLRender;
    FOnItemPrinting: TElXPrintTreeItemEvent;
    FOnSectionPrinting : TElXPrintHeaderSectionEvent;

    FTree: TCustomElXTree;

    FHeaderPS: TElXHeaderPrintSettings;
    FTreePS: TElXTreePrintSettings;

    procedure DoDrawHeader (Canvas : TCanvas; ARect : TRect; ATree: TCustomElXTree);
    procedure TriggerItemPrintingEvent(Item : TElXTreeItem; var Print : boolean); virtual;
    procedure TriggerSectionPrintingEvent(Section : TElXHeaderSection; var Print : boolean); virtual;
    procedure TriggerAfterPage(PageNumber : integer); virtual;
    procedure TriggerBeforePage(PageNumber : integer); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPageNumbersLayout(Reader: TReader);
    procedure DoDrawPageNumber(PageNumber : integer); virtual;
    procedure DoDrawCaption(PageNumber : integer; var Rec: TRect); virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Print;
  published
    property PrintAsIs: boolean read FPrintAsIs write SetPrintAsIs;
    //header print settings property
    property HeaderPrintSettings: TElXHeaderPrintSettings read FHeaderPS write SetHeaderPS;
    //tree print settings property
    property TreePrintSettings: TElXTreePrintSettings read FTreePS write SetTreePS;
    property Tree: TCustomElXTree read FTree write SetTree;
    //page settings properties
    property ShowPageNumbers: Boolean read FShowPageNumbers write FShowPageNumbers default true;
    property PageNumbersLayout: TPNLayout read FPageNumbersLayout write FPageNumbersLayout default plTop;
    property PageNumbersText: TLMDString read FPageNumbersText write FPageNumbersText;
    property PageNumbersAlignment: TAlignment read FPageNumbersAlignment write FPageNumbersAlignment default taCenter;
    property Caption: TLMDString read FCaption write FCaption;
    //events
    property OnAfterPage: TPageEvent read FOnAfterPage write FOnAfterPage;
    property OnBeforePage: TPageEvent read FOnBeforePage write FOnBeforePage;
    property OnItemPrinting: TElXPrintTreeItemEvent read FOnItemPrinting write FOnItemPrinting;
    property OnSectionPrinting : TElXPrintHeaderSectionEvent read FOnSectionPrinting write FOnSectionPrinting;
    property OnDrawPageNumber: TDrawPageNumberEvent read FOnDrawPageNumber write FOnDrawPageNumber;
    property OnDrawCaption: TDrawPageCaptionEvent read FOnDrawCaption write FOnDrawCaption;
  end;

  TElXTreePrintSettings = class (TPersistent)
  private
    FPrinter: TElXTreePrinter;
    FFont: TFont;
    FScale: Integer;
    FStripedEvenColor: TColor;
    FStripedItems: Boolean;
    FStripedOddColor: TColor;
    FHorzDivLinesColor: TColor;
    FVertDivLinesColor: TColor;
    FStyle: TElXCellStyle;
    FPrintOptions: TElXTreePrintOptions;
    procedure Init(APrinter:TElXTreePrinter);
    procedure SetPrintOptions(const Value: TElXTreePrintOptions);
    procedure SetScale(Value: Integer);
    procedure SetStyle(const Value: TElXCellStyle);
    procedure SetVertDivLinesColor(const Value: TColor);
    procedure SetHorzDivLinesColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetStripedEvenColor(const Value: TColor);
    procedure SetStripedItems(const Value: Boolean);
    procedure SetStripedOddColor(const Value: TColor);
    function GetTextColor: TColor;
    procedure SetFont(const Value: TFont);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Style: TElXCellStyle read FStyle write SetStyle;
  published
    property Font: TFont read FFont write SetFont;
    property Scale: Integer read FScale write SetScale default 100;
    property StripedEvenColor: TColor read FStripedEvenColor write SetStripedEvenColor;
    property StripedItems: Boolean read FStripedItems write SetStripedItems default false;
    property StripedOddColor: TColor read FStripedOddColor write SetStripedOddColor;
    property TextColor: TColor read GetTextColor write SetTextColor;
    property HorzDivLinesColor: TColor read FHorzDivLinesColor write SetHorzDivLinesColor;
    property VertDivLinesColor: TColor read FVertDivLinesColor write SetVertDivLinesColor;
    property TreePrintOptions:  TElXTreePrintOptions read FPrintOptions write SetPrintOptions;
  end;

  TElXHeaderPrintSettings = class (TPersistent)
  private
    FPrinter: TElXTreePrinter;
    FColor:TColor;
    FFont: TFont;
    FHeight: integer;
    FPrintOptions : TElXHeaderPrintOptions;
    procedure SetFont(const Value: TFont);
    procedure SetColor(const Value: TColor);
    procedure SetHeight(const Value: integer);
    procedure SetPrintOptions(const Value: TElXHeaderPrintOptions);
    procedure Init(APrinter:TElXTreePrinter);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor default clWhite;
    property Font: TFont read FFont write SetFont;
    property Height: integer read FHeight write SetHeight;
    property HeaderPrintOptions:  TElXHeaderPrintOptions read FPrintOptions write SetPrintOptions;
  end;

implementation

type
  THackElXTree = class(TCustomElXTree)
    property Header;
    property HeaderHeight;
    property OnHTMLImageNeeded;
    property HeaderSections;
    property HeaderColor;
    property HeaderFont;
    property HeaderFlat;
    property VirtualityLevel;
    property MainTreeColumn;
    property OwnerDrawByColumn;
    property RightAlignedView;
    property RightAlignedText;
    property FilteredVisibility;
    property ItemIndent;
    property OwnerDrawMask;
    property CustomPlusMinus;
    property PlusPicture;
    property LeafPicture;
    property MinusPicture;
    property CustomCheckBoxes;
    property RadioButtonGlyph;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Images;
    property Images2;
    property ChangeStateImage;
    property RowSelect;
    property LinesStyle;
    property LinesColor;
    property VerticalLines;
    property VertDivLinesColor;
    property HorizontalLines;
    property HorzDivLinesColor;
    property ShowLines;
    property ShowRoot;
    property ShowImages;
    property ShowButtons;
    property ShowLeafButton;
    property ShowCheckBoxes;
    property ShowEmptyImages;
    property ShowEmptyImages2;
    property StripedItems;
    property StripedEvenColor;
    Property StripedOddColor;
    property ShowColumns;
    property Style;
    property HeaderWrapCaptions;
    end;

  THackElXTreeHeader = class(TElXTreeHeader)
    function GetXFixedColNum:Integer;

    function GetDragSectionRect(SectionPos: integer): TRect;override;
    procedure DoSectionDraw(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean); override;
    function GetXSectionRect(AItemNum, SectionPos: integer): TRect;reintroduce;
    procedure RedrawSectionCell(ACanvas: TCanvas; ASection: TElHeaderSection; AR: TRect; AxHOffs: integer; ADithered: Boolean; ARowIndex: Integer); override;

  end;

function THackElXTreeHeader.GetXFixedColNum:Integer;
begin
  result:=FFixedColNum;
end;

function THackElXTreeHeader.GetDragSectionRect(SectionPos: integer): TRect;
begin
   result:=inherited GetDragSectionRect(SectionPos);
end;

procedure THackElXTreeHeader.DoSectionDraw(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean);
begin
  inherited;
end;

function THackElXTreeHeader.GetXSectionRect(AItemNum, SectionPos: integer): TRect;
begin
  Result := inherited GetXSectionRect(AItemNum, SectionPos);
end;

procedure THackElXTreeHeader.RedrawSectionCell(ACanvas: TCanvas; ASection: TElHeaderSection; AR: TRect; AxHOffs: integer; ADithered: Boolean; ARowIndex: Integer);
begin
  inherited;
end;

type
  THackElXHeaderSection = class(TElXHeaderSection);

type
  THackElXCellControl = class(TElXCellControl);
  THackElXTreeItem = class(TElXTreeItem);

  THackElXTreeView = class(TElXTreeView)

      procedure DoRedrawItem(ACanvas: TCanvas; AItem: TElXTreeItem; AItemRect, ASurfRect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1);override;

  end;

procedure THackElXTreeView.DoRedrawItem(ACanvas: TCanvas; AItem: TElXTreeItem; AItemRect, ASurfRect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1);
begin
  inherited;
end;

procedure TElXTreePrinter.DoDrawHeader(Canvas : TCanvas; ARect : TRect; ATree: TCustomElXTree);

  procedure DrawSectionsRange(AItem: TElXHeaderCellRow; AItemNum: Integer; AMin, AMax: Integer);
  var
    i: Integer;
    LCell: TElXHeaderCell;
    LR, LTmpR: TRect;
    LSection: TElXHeaderSection;
    LPaint : boolean;
    LDelta:integer;
  begin
    for i := AMin to AMax do
    begin
      LCell := AItem.Cell[i];
      LSection := LCell.HeaderSection;
      if not Assigned(LSection) or not LSection.Visible then
        continue;
      TriggerSectionPrintingEvent(LSection, LPaint);
      if not LPaint then
        continue;
      LR := THackElXTreeHeader(THackElXTree(ATree).Header).GetDragSectionRect(LSection.Position);
      LDelta := ARect.Top - LR.Top;
      inc(LR.Top, LDelta);
      inc(LR.Bottom, LDelta);
      if IntersectRect(LTmpR, LR, Canvas.ClipRect) and (LSection.Style = elhsOwnerDraw) then
        THackElXTreeHeader(THackElXHeaderSection(LSection).Owner).DoSectionDraw(Canvas, LSection, LR, False);
      if not Assigned(LCell) or (LCell.JointCellRole = jcrSlave) then
        continue;
      SetRectEmpty(LR);
      LR := THackElXTreeHeader(THackElXHeaderSection(LSection).Owner).GetXSectionRect(AItemNum, LSection.Position);
      inc(LR.Top, LDelta);
      inc(LR.Bottom, LDelta);
      THackElXTreeHeader(THackElXHeaderSection(LSection).Owner).RedrawSectionCell(Canvas, LCell.HeaderSection, LR, 0, False,AItemNum);
    end;
  end;

var
  R: TRect;
  i: Integer;
  LCount: Integer;
  LItem: TElXHeaderCellRow;
  LHeader: THackElXTreeHeader;
begin
  if IsRectEmpty(Canvas.ClipRect) then
    Exit;
  LHeader := THackElXTreeHeader(THackElXTree(ATree).Header);
  for i := THackElXTreeHeader(THackElXTree(ATree).Header).RowsList.Count - 1 downto 0 do
  begin
    LItem := LHeader.Rows[i];
    LCount := LItem.Count - 1;
    DrawSectionsRange(LItem, i, LHeader.GetXFixedColNum, LCount  );
    DrawSectionsRange(LItem, i, 0, LHeader.GetXFixedColNum - 1);
  end;
  R := LHeader.ClientRect;
  Dec(R.Right,THackElXTree(ATree).GutterWidth);
  R.Left := LHeader.SectionsWidth - LHeader.LeftPos;
  Dec(R.Right,THackElXTree(ATree).GutterWidth);
end;

procedure TElXTreePrinter.SetTree(Value: TCustomElXTree);
begin
  if FTree <> Value then
  begin
    if (FTree <> nil) then
      if not (csDestroying in FTree.ComponentState) then
        FTree.RemoveFreeNotification(Self);
    if (Printer <> nil) and Printer.Active then
      raise EPrinterError.Create('Can''t change tree object while printing');
    FTree := Value;
    if FTree<>nil then
    begin
      FRender.OnImageNeeded := THackElXTree(FTree).OnHTMLImageNeeded;
      if csDesigning in ComponentState then
        FHeaderPS.Height := THackElXTree(Tree).HeaderHeight;
    end
    else
      FRender.OnImageNeeded := nil;
    if FTree <> nil then
      FTree.FreeNotification(Self);
  end;
end;

procedure TElXTreePrinter.TriggerItemPrintingEvent(Item : TElXTreeItem; var Print
    : boolean);
begin
  Print := true;
  if Assigned(FOnItemPrinting) then
    FOnItemPrinting(Self, Item, Print);
end;

procedure TElXTreePrinter.TriggerSectionPrintingEvent(Section : TElXHeaderSection; var Print : boolean);
begin
  Print := true;
  if assigned(FOnSectionPrinting) then
    FOnSectionPrinting(Self, Section, Print);
end;

constructor TElXTreePrinter.Create(AOwner : TComponent);
begin
  inherited;
  FTreePS := TElXTreePrintSettings.Create;
  FTreePS.Init(Self);

  FTreePS.Scale := 100;

  FHeaderPS := TElXHeaderPrintSettings.Create;
  FHeaderPS.Init(Self);

  FRender := TLMDHTMLRender.Create;
  FRender.DoubleBuffered := False;
  FShowPageNumbers := True;
  FPageNumbersLayout := plTop;
  FPageNumbersText := 'Page ';
  FPageNumbersAlignment := taCenter;
end;

destructor TElXTreePrinter.Destroy;
begin
  FRender.Free;
  FTreePS.Free;
  FHeaderPS.Free;
  inherited;
end;

procedure TElXTreePrinter.Print;
var i,j : integer;
    pa:  boolean;
    R1: TRect;
    DC: HDC;
    Item : TElXTreeItem;
    Print : boolean;
    SaveMapMode : integer;
    SaveLogExtEx,
    SavePhExtEx : TSize;

    PhExtX,
    PhExtY,
    LogExtX,
    LogExtY  : integer;
    ACanvas:TCanvas;
    LTree: TCustomElXTree;
    LDummyForm: TForm;
begin
  i  := 0;

  if Tree = nil then raise EElXTreePrinterError.Create('No tree assigned to ElTreePrinter');
  if Printer = nil then exit;

  if not PrintAsIs then
  begin
    LDummyForm := TForm.Create(nil);
    LDummyForm.Visible := false;
    LTree := TCustomElXTree.Create(Tree.Owner);
    LTree.Parent := LDummyForm;
    THackElXTree(LTree).HeaderSections.Assign(THackElXTree(Tree).HeaderSections);
    LTree.Assign(Tree);
    SetTreeProps(LTree);
  end;

  if PrintAsIs then
  begin
    Tree.DeselectAll;
    Tree.HScrollBar.Position := 0;
  end
  else
  begin
    LTree.DeselectAll;
    LTree.HScrollBar.Position := 0;
  end;

  pa := Printer.Active;
  if not pa then
    Printer.BeginDoc;
  FPrinting := true;

  DC := GetDC(0);
  LogExtX := MulDiv(Printer.PageWidth, GetDeviceCaps(DC, LOGPIXELSX) * 100, FTreePs.Scale * 2540);
  LogExtY := MulDiv(Printer.PageHeight, GetDeviceCaps(DC, LOGPIXELSY) * 100, FTreePs.Scale * 2540);

  ReleaseDC(0, DC);
  PhExtX := MulDiv(Printer.PageWidth, GetDeviceCaps(Printer.PrinterDC, LOGPIXELSX), 2540);
  PhExtY := MulDiv(Printer.PageHeight, GetDeviceCaps(Printer.PrinterDC, LOGPIXELSY), 2540);

  if not PrintAsIs then
  begin
    LTree.Width := LogExtX;
    LTree.Height := LogExtY;
  end;

  try
    with Printer.Canvas[Printer.PageIndex] do
    begin
      SaveMapMode := GetMapMode(Handle);
      SetMapMode(Handle, MM_ANISOTROPIC);
      SetWindowExtEx(Handle, LogExtX, LogExtY, @SaveLogExtEx);
      SetViewPortExtEx(Handle, PhExtX, PhExtY, @SavePhExtEx);
    end;

    SetRectEmpty(R1);

    R1.Right := LogExtX;
    TriggerBeforePage(Printer.PageIndex);
    DoDrawCaption(Printer.PageIndex, R1);

    while true do
    begin
      SetRectEmpty(R1);

      R1.Right := LogExtX;
      DoDrawCaption(Printer.PageIndex, R1);

      if (tpoShowHeader in FTreePS.TreePrintOptions)
        and ((Printer.PageIndex = 0) or (hpoPrintOnEveryPage in FHeaderPS.HeaderPrintOptions)) then
      begin
        R1.Top := R1.Bottom;
        if PrintAsIs then
        begin
          R1.Bottom := R1.Bottom + THackElXTree(Tree).HeaderSections.Owner.CalcHeaderHeight;
          DoDrawHeader(Printer.Canvas[Printer.PageIndex], R1, Tree);
        end
        else
        begin
          R1.Bottom := R1.Bottom + THackElXTree(LTree).HeaderSections.Owner.CalcHeaderHeight;
          DoDrawHeader(Printer.Canvas[Printer.PageIndex], R1, LTree);
        end;
      end;
      while true do
      begin
        R1.Top := R1.Bottom;
        if i >= Integer(THackElXTree(Tree).Items.Count) then
          break;
        if PrintAsIs then
          Item := THackElXTree(Tree).Items[i]
        else
        begin
          Item := THackElXTree(LTree).Items[i];
        end;
        if Item = nil then
          break;
        if ((not (tpoShowHiddenItems in FTreePS.TreePrintOptions) or PrintAsIs) and Item.Hidden and THackElXTree(Tree).FilteredVisibility) or
           ((not (tpoShowInvisibleItems in FTreePS.TreePrintOptions) or PrintAsIs) and not Item.IsVisible) then
          begin
            inc(i);
            Continue;
          end;
        TriggerItemPrintingEvent(Item, Print);
        if not Print then
        begin
          inc(i);
          Continue;
        end;
        if LogExtY - R1.Top < Item.Height then
        begin
          TriggerAfterPage(Printer.PageIndex);
          with Printer.Canvas[Printer.PageIndex] do
          begin
            SetWindowExtEx(Handle, SaveLogExtEx.CX, SaveLogExtEx.CY, nil);
            SetViewPortExtEx(Handle, SavePhExtEx.cx, SavePhExtEx.CY, nil);
            SetMapMode(Handle, SaveMapMode);
          end;

          Printer.NewPage;

          with Printer.Canvas[Printer.PageIndex] do
          begin
            SaveMapMode := GetMapMode(Handle);
            SetMapMode(Handle, MM_ANISOTROPIC);
            SetWindowExtEx(Handle, LogExtX, LogExtY, @SaveLogExtEx);
            SetViewPortExtEx(Handle, PhExtX, PhExtY, @SavePhExtEx);
          end;
          TriggerBeforePage(Printer.PageIndex);
          break;
        end
        else
        begin
          R1.Bottom := R1.Top + Item.Height;
          ACanvas := Printer.Canvas[Printer.PageIndex];
          if PrintAsIs then
          begin
            THackElXTreeView(Tree.View).DoRedrawItem(ACanvas, Item, R1, R1, false, Item.AbsoluteIndex)
          end
          else
          begin
            Item.UseOwnStyle := tpoUseItemStyles in FTReePS.TreePrintOptions;
            for j:=0 to Item.Cells.Count - 1 do
              Item.Cells[j].UseOwnStyle := tpoUseCellStyles in FTReePS.TreePrintOptions;
            THackElXTreeView(LTree.View).DoRedrawItem(ACanvas, Item, R1, R1, false);
          end;
          inc(i);
        end;
      end;
      if i = Integer(THackElXTree(Tree).Items.Count) then
        break;
    end;
    TriggerAfterPage(Printer.PageIndex);
    with Printer.Canvas[Printer.PageIndex] do
    begin
      SetWindowExtEx(Handle, SaveLogExtEx.cx, SaveLogExtEx.cy, nil);
      SetViewPortExtEx(Handle, SavePhExtEx.cx, SavePhExtEx.cy, nil);
      SetMapMode(Handle, SaveMapMode);
    end;

  finally
    if not PrintAsIs then
    begin
      FreeAndNil(LTree);
      FreeAndNil(LDummyForm);
    end;
    if not pa then
      Printer.EndDoc;
    FPrinting := false;
    if DC <> 0 then
      ReleaseDC(0, DC);
  end;
end;

procedure TElXTreePrinter.TriggerAfterPage(PageNumber : integer);
begin
  if FShowPageNumbers and (FPageNumbersLayout = plBottom) then DoDrawPageNumber(PageNumber);
  if Assigned(FOnAfterPage) then FOnAfterPage(Self, PageNumber);
end;

procedure TElXTreePrinter.TriggerBeforePage(PageNumber : integer);
begin
  if Assigned(FOnBeforePage) then FOnBeforePage(Self, PageNumber);
  if FShowPageNumbers and (FPageNumbersLayout = plTop) then DoDrawPageNumber(PageNumber);
end;

procedure TElXTreePrinter.ReadPageNumbersLayout(Reader: TReader);
var
  LIdent: String;
begin
  Lident := Reader.ReadIdent;
  if LIdent = 'plTop' then
    PageNumbersLayout := plTop
  else
    if LIdent = 'plBottom' then
      PageNumbersLayout := plBottom;
end;

procedure TElXTreePrinter.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('PageNambersLayout', ReadPageNumbersLayout, nil, False);
end;

procedure TElXTreePrinter.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FTree then
      Tree := nil;
  end;
end;

procedure TElXTreePrinter.DoDrawPageNumber(PageNumber : integer);
var S : TLMDString;
    R : TRect;
    PageHeight,
    HPP,
    WP,
    HP: integer;
    FDC : THandle;
begin
  S  := FPageNumbersText + IntToStr(PageNumber + 1);
  if Assigned(FOnDrawPageNumber) then
    FOnDrawPageNumber(Self, S, PageNumber);
  FDC:= GetDC(0);
  PageHeight := MulDiv(Printer.PageHeight, GetDeviceCaps(FDC, LOGPIXELSY) * 100, FTreePS.Scale * 2540);
  WP := MulDiv(Printer.PageWidth, GetDeviceCaps(FDC, LOGPIXELSX), 2540);
  HP := MulDiv(Printer.TopMargin, GetDeviceCaps(FDC, LOGPIXELSY), 2540);
  HPP:= MulDiv(Printer.BottomMargin, GetDeviceCaps(FDC, LOGPIXELSY), 2540);
  ReleaseDC(0, FDC);
  if FPageNumbersLayout = plTop then
    R.Top  := -(HP - Printer.Canvas[PageNumber].TextHeight(S)) div 2
  else
    R.Top := PageHeight + abs(HPP-Printer.Canvas[PageNumber].TextHeight(S)) div 2;

  if FPageNumbersAlignment <> taLeftJustify then
  begin
    R.Left := (WP - Printer.Canvas[PageNumber].TextWidth(S)){ div 2};
    if FPageNumbersAlignment = taCenter then
      R.Left := R.Left div 2;
  end
  else
    R.Left := 0;

  if Pos('<html>', s) = 1 then
  begin
    FRender.Data.DefaultBgColor := Printer.Canvas[PageNumber].Brush.Color;
    FRender.Data.DefaultColor := FTreePS.Font.Color;
    FRender.Data.DefaultStyle := FTreePS.Font.Style;
    FRender.Data.DefaultHeight := FTreePS.Font.Height;
    FRender.Data.DefaultFont := FTreePS.Font.Name;
    FRender.Data.Charset := FTreePS.Font.Charset;
    FRender.PrepareText(S, 0, false);
    R.Right := R.Left + FRender.Data.TextSize.cx;
    R.Bottom := R.Top + FRender.Data.TextSize.cy;

    FRender.DrawText(Printer.Canvas[PageNumber], Point(0, 0), R, clNone);
  end
  else
  Printer.Canvas[PageNumber].TextOut(R.Left, R.Top, S);
end;

procedure TElXTreePrinter.DoDrawCaption(PageNumber : integer; var Rec: TRect);
begin
  inc(Rec.Left,Tree.GutterWidth);
  if Pos('<html>', FCaption) = 1 then
  begin
    FRender.Data.DefaultBgColor := Printer.Canvas[PageNumber].Brush.Color;
    FRender.Data.DefaultColor := FTreePS.Font.Color;
    FRender.Data.DefaultStyle := FTreePS.Font.Style;
    FRender.Data.DefaultHeight := FTreePS.Font.Height;
    FRender.Data.DefaultFont := FTreePS.Font.Name;
    FRender.Data.Charset := FTreePS.Font.Charset;
    FRender.PrepareText(FCaption, 0, false);
    Rec.Bottom := Rec.Top + FRender.Data.TextSize.cy;
  end
  else
    Rec.Bottom:= Rec.Top+Printer.Canvas[PageNumber].TextHeight(FCaption);

  if Assigned(FOnDrawCaption) then
    FOnDrawCaption(Self, FCaption, PageNumber, Rec);

  if Pos('<html>', FCaption) = 1 then
    FRender.DrawText(Printer.Canvas[PageNumber], Point(0, 0), Rec, clNone)
  else
    Printer.Canvas[PageNumber].TextOut(Rec.Left, Rec.Top, FCaption);
  Inc(Rec.Bottom);
end;

procedure TElXTreePrinter.SetTreeProps(ATree: TCustomElXtree);
var
  i:integer;
begin
  THackElXTree(ATree).VerticalLines := tpoShowVerticalLines in FTreePS.TreePrintOptions;
  THackElXTree(ATree).VertDivLinesColor := FTreePS.VertDivLinesColor;
  THackElXTree(ATree).HorizontalLines := tpoShowHorizontalLines in FTreePS.TreePrintOptions;
  THackElXTree(ATree).HorzDivLinesColor := FTreePS.HorzDivLinesColor;
  THackElXTree(ATree).ShowRoot := tpoShowRoot in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowLines := tpoShowLines in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowImages := tpoShowImages in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowButtons := tpoShowButtons in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowLeafButton := tpoShowLeafButton in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowCheckBoxes := tpoShowCheckBoxes in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowEmptyImages := tpoShowEmptyImages in FTreePS.TreePrintOptions;
  THackElXTree(ATree).ShowEmptyImages2 := tpoShowEmptyImages2 in FTreePS.TreePrintOptions;
  THackElXTree(ATree).StripedItems := FTreePS.StripedItems;
  THackElXTree(ATree).StripedEvenColor := FTreePS.StripedEvenColor;
  THackElXTree(ATree).StripedOddColor := FTreePS.StripedOddColor;
  THackElXTree(ATree).ShowColumns := tpoShowColumns in FTreePS.TreePrintOptions;
  THackElXTree(ATree).Font.Assign(FTReePS.Font);
  THackElXTree(ATree).Style.Assign(FTReePS.Style);
  THackElXTree(ATree).HeaderColor := FHeaderPS.Color;
  THackElXTree(ATree).HeaderFont.Assign(FHeaderPS.Font);
  THackElXTree(ATree).HeaderFlat := hpoFlat in FHeaderPS.HeaderPrintOptions;
  THackElXTree(ATree).HeaderHeight := FHeaderPS.Height;
  THackElXTree(ATree).HeaderWrapCaptions := hpoWrapCaptions in FHeaderPS.HeaderPrintOptions;

  for i:=0 to THackElXTree(ATree).HeaderSections.Count - 1 do
  begin
    THackElXTree(ATree).HeaderSections[i].ShowSortMark := hpoShowSortMarks in FHeaderPS.HeaderPrintOptions;
    if tpoShowHiddenSections in FTreePS.TreePrintOptions then
      THackElXTree(ATree).HeaderSections[i].Visible := true;
  end;
  if not (hpoShowImages in FHeaderPS.HeaderPrintOptions) then
    THackElXTree(ATree).Header.Images := nil;
end;

procedure TElXTreePrinter.SetHeaderPS(
  const Value: TElXHeaderPrintSettings);
begin
  if FHeaderPS <> Value then
  begin
    if (Printer <> nil) and Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FHeaderPS.Assign(Value);
  end;
end;

procedure TElXTreePrinter.SetPrintAsIs(const Value: boolean);
begin
  if FPrintAsIs <> Value then
  begin
    if (Printer <> nil) and Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FPrintAsIs := Value;
  end;
end;

{ TElXTreePrintSettings }

procedure TElXTreePrintSettings.Assign(Source: TPersistent);
var
  TPS: TElXTreePrintSettings;
begin
  if Source is (TElXTreePrintSettings) then
  begin
    TPS := TElXTreePrintSettings(Source);
    FFont.Assign(TPS.Font);
    FStyle.Assign(TPS.Style);
    FScale := TPS.Scale;
    FStripedEvenColor := TPS.StripedEvenColor;
    FStripedItems := TPS.StripedItems;
    FStripedOddColor := TPS.StripedOddColor;
    FHorzDivLinesColor := TPS.HorzDivLinesColor;
    FVertDivLinesColor := TPS.VertDivLinesColor;
    FPrintOptions := TPS.TreePrintOptions;
  end;
end;

constructor TElXTreePrintSettings.Create;
begin
  inherited;
  FFont := TFont.Create;
  FStyle := TElXCellStyle.Create(nil,nil);
  FStripedEvenColor := clBtnHighlight;
  FStripedOddColor := clBtnShadow;
  FHorzDivLinesColor := clBtnFace;
  FVertDivLinesColor := clBtnFace;
end;

destructor TElXTreePrintSettings.Destroy;
begin
  FFont.Free;
  FStyle.Free;
  inherited;
end;

procedure TElXTreePrintSettings.Init(APrinter: TElXTreePrinter);
begin
  FPrinter := APrinter;
end;

procedure TElXTreePrintSettings.SetPrintOptions(
  const Value: TElXTreePrintOptions);
begin
  if FPrintOptions <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FPrintOptions := Value;
  end;
end;

procedure TElXTreePrinter.SetTreePS(const Value: TElXTreePrintSettings);
begin
  if FTreePS <> Value then
  begin
    if (Printer <> nil) and Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FTreePS.Assign(Value);
  end;
end;

procedure TElXTreePrintSettings.SetScale(Value: Integer);
begin
  if FScale <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FScale := Value;
  end;
end;

procedure TElXTreePrintSettings.SetHorzDivLinesColor(const Value: TColor);
begin
  if FHorzDivLinesColor <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FHorzDivLinesColor := Value;
  end;
end;

procedure TElXTreePrintSettings.SetVertDivLinesColor(const Value: TColor);
begin
  if FVertDivLinesColor <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FVertDivLinesColor := Value;
  end;
end;

procedure TElXTreePrintSettings.SetStyle(const Value: TElXCellStyle);
begin
  if FStyle<>Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FStyle.Assign(Value);
  end;
end;

procedure TElXTreePrintSettings.SetTextColor(const Value: TColor);
begin
  if FStyle.TextColor <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FStyle.TextColor := Value;
  end;
end;

procedure TElXTreePrintSettings.SetStripedEvenColor(const Value: TColor);
begin
  FStripedEvenColor := Value;
  if FStripedEvenColor <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FStripedEvenColor := Value;
  end;
end;

procedure TElXTreePrintSettings.SetStripedItems(const Value: Boolean);
begin
  if FStripedItems <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FStripedItems := Value;
  end;
end;

procedure TElXTreePrintSettings.SetStripedOddColor(const Value: TColor);
begin
  if FStripedOddColor <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FStripedOddColor := Value;
  end;
end;

function TElXTreePrintSettings.GetTextColor: TColor;
begin
  result := Style.TextColor;
end;

procedure TElXTreePrintSettings.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FFont.Assign(Value);
    if FFont <> nil then
    begin
      Style.FontSize := Font.Size;
      Style.FontStyles := Font.Style;
      Style.FontName := Font.Name;
      Style.TextColor := Font.Color;
    end;
  end;
end;

{ TElXHeaderPrintSettings }

procedure TElXHeaderPrintSettings.Assign(Source: TPersistent);
var
  LHPS:TElXHeaderPrintSettings;
begin
  if Source is (TElXHeaderPrintSettings) then
  begin
    LHPS := TElXHeaderPrintSettings(Source);
    FColor := LHPS.Color;
    FFont := LHPS.Font;
    FHeight := LHPS.Height;
    FPrintOptions := LHPS.HeaderPrintOptions;
  end;
end;

constructor TElXHeaderPrintSettings.Create;
begin
  inherited;
  FFont := TFont.Create;
end;

destructor TElXHeaderPrintSettings.Destroy;
begin
  FFont.Free;
end;

procedure TElXHeaderPrintSettings.Init(APrinter: TElXTreePrinter);
begin
  FPrinter := APrinter;
end;

procedure TElXHeaderPrintSettings.SetColor(const Value: TColor);
begin
   FColor := Value;
end;

procedure TElXHeaderPrintSettings.SetFont(const Value: TFont);
begin
  if FFOnt <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FFont.Assign(Value);
  end;
end;

procedure TElXHeaderPrintSettings.SetHeight(const Value: integer);
begin
  FHeight := Value;
end;

procedure TElXHeaderPrintSettings.SetPrintOptions(
  const Value: TElXHeaderPrintOptions);
begin
  if FPrintOptions <> Value then
  begin
    if (FPrinter.Printer <> nil) and FPrinter.Printer.Active then
      raise EPrinterError.Create('Can''t change properties while printing');
    FPrintOptions := Value;
  end;
end;

end.
