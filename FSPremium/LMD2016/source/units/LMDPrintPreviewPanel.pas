unit LMDPrintPreviewPanel;
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

LMDPrintPreviewPanel unit (RM)
------------------------------
Preview Panel for printing tasks

Changes
-------
Release 8.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Math, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, ToolWin, ComCtrls, ImgList, Buttons,
  LMDPrinter, LMDSHSpinEdit, LMDTypes, LMDCustomControl, intfLMDBase;

const
  LMDPrintZoomValues: array[0..7] of Integer =
                     (500, 200, 150, 100, 75, 50 , 25, 10);

  LMDPrintPreviewDefaultMargin = 20;

type

  TLMDPrintPreviewMode = (pmExactScale,
                          pmWholePage, pmTextWidth, pmTwoPages,
                          pmExactMultiPages);

  TLMDPrintPreviewPanel = class;

  {************************ TLMDPrintChangeLink *******************************}
  TLMDPrintChangeLink = class
  private
    FSender:TLMDPrintPreviewPanel;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TLMDPrintPreviewPanel read FSender write FSender;
  end;

  TLMDPrintPreviewChange = (pcMode, pcScale, pcCurrentPage, pcScroll, pcResize);

  {************************ TLMDPrintPreviewPanel *****************************}
  TLMDPrintPreviewPanel = class(TCustomControl, ILMDComponent)
  private
    FAbout    : TLMDAboutVar;
    FClients: TList;
    FOnChange: TNotifyEvent;

    // Controls
    FHScroll, FVScroll: TScrollBar;
    FPaintPanel: TCustomControl;

    FScale: Integer;
    FRealScale: Integer;

    FCurrentPage: Integer;
    FTotalPages: Integer;

    FHorzPages,
    FVertPages: Integer;

    FPagePanels: Integer;

    FPageRects: array of TRect;
    FPageRectsNumbers: array of Integer;

    FPrinterFullWidthMM,
    FPrinterFullHeightMM: Double;

    FPrinterHlp: TLMDPrinterHelper;
    FPrinter: TLMDPrinterBase;
    FMargin: Integer;
    FLst: TLMDPrinterListener;
    FMode: TLMDPrintPreviewMode;

    FBmp: Graphics.TBitmap;

    FHandleCreated: Boolean;
    FDestroing: Boolean;

    FMouseWheelAcc: Integer;

    procedure SetPagesNum(ANum: Integer);
    procedure ClearPageRects;
    //////

    procedure CheckPrinterAssigned;

    procedure SetPrinterHelper(AValue: TLMDPrinterHelper);

    procedure SetCurrentPage(AValue: Integer);
    procedure SetMargin(AValue: Integer);

    procedure SetScale(AValue: Integer);
    procedure SetMode(AValue: TLMDPrintPreviewMode);

    procedure ScrollChange(ASender: TObject);
    //////
    procedure PaintContent;
  protected
    procedure UpdateScaleMode(AChange: TLMDPrintPreviewChange);

    procedure DoPanelKeyDown(Key: Word; Shift: TShiftState);
    procedure Resize; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;

    function  DoMouseWheel(Shift: TShiftState; WheelDelta:
                           Integer; MousePos: TPoint): Boolean; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetVars;

    // BroadCast Changes to connected controls
    procedure Change;

    // Linked Controls support
    procedure RegisterChanges(AValue: TLMDPrintChangeLink);
    procedure UnRegisterChanges(AValue: TLMDPrintChangeLink);

    // to be changed...
    procedure SetMultiPages(AHorzPages, AVertPages: Integer;
                            ADoChangeMode: Boolean);

    // helper functions for ToolBar
    procedure Zoom(AZoomIn: Boolean);

    function getLMDPackage:TLMDPackageID;

    // Access to connected TLMDPrinter control
    property PrinterHelper: TLMDPrinterHelper read FPrinterHlp write SetPrinterHelper;

    property TotalPages: Integer read FTotalPages;
    property CurrentPage: Integer read FCurrentPage write SetCurrentPage;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property Scale: Integer read FScale write SetScale;
    property RealScale: Integer read FRealScale;

    property Mode: TLMDPrintPreviewMode read FMode write SetMode;

    property Margin: Integer read FMargin write SetMargin
                             default LMDPrintPreviewDefaultMargin;
    ////////
    property Align;

    property Color default clBtnShadow;

    ////////
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnResize;
  end;

implementation
uses
  LMDProcs, LMDPrintConst;

type
  THelperLst = class(TLMDPrinterListener)
  private
    FPanel: TLMDPrintPreviewPanel;
  public
    constructor Create(APanel: TLMDPrintPreviewPanel);
    procedure Refresh(AChanges: TLMDPrinterChangeKinds); override;
  end;

  TMyPaintPanel = class(TCustomControl)
  private
    FParent: TLMDPrintPreviewPanel;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ ******************** TLMDPrintChangeLink ************************************}
{----------------------- public -----------------------------------------------}
destructor TLMDPrintChangeLink.Destroy;
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{********************* TLMDPrintPreviewPanel **********************************}
{------------------------ private ---------------------------------------------}
procedure TLMDPrintPreviewPanel.SetCurrentPage(AValue: Integer);
begin
  CheckPrinterAssigned;

  if FCurrentPage <> AValue then
  begin
    if (AValue < 0) or (AValue >= FPrinterHlp.GetPagesCount(orAll)) then
      raise ELMDPrintPackError.CreateFmt(SLMDPrintPvBadCurrentPageArg,
                                       [FPrinterHlp.GetPagesCount(orAll)-1,
                                        AValue]);

    FCurrentPage := AValue;

    UpdateScaleMode(pcCurrentPage);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.SetPrinterHelper(AValue : TLMDPrinterHelper);
begin
  if FPrinterHlp<>AValue then
  begin
    if FPrinterHlp<>nil then
      FPrinterHlp.RemoveListener(FLst);

    FPrinterHlp := AValue;

    FCurrentPage := 0;

    if FPrinterHlp<>nil then
    begin
      FPrinter := FPrinterHlp.GetPrinter;
      FPrinterHlp.AddListener(FLst);
    end
    else
      FPrinter := nil;

    UpdateScaleMode(pcMode);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.SetScale(AValue: Integer);
begin
  if FScale=AValue then
    Exit;

  if AValue <= 0 then
    raise ELMDPrintPackError.Create(SLMDPrintPvBadScaleArg);

  FScale := AValue;

  UpdateScaleMode(pcScale);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.PaintContent;
var
  i: Integer;

  Cnv: TCanvas;
begin
  Cnv := FBmp.Canvas;

  Cnv.Brush.Style := bsSolid;
  Cnv.Brush.Color := clBtnShadow;
  Cnv.FillRect(Rect(0, 0, FBmp.Width, FBmp.Height));

  if Assigned(FPrinterHlp) then
  begin
    for i:=0 to FPagePanels-1 do
      FPrinterHlp.DrawPage(orAll, FPageRectsNumbers[i], Cnv, FPageRects[i]);
  end;

  TMyPaintPanel(FPaintPanel).Canvas.Draw(0, 0, FBmp);
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDPrintPreviewPanel.Change;
var
  i:Integer;
begin
  if (csLoading in ComponentState) then
   Exit;

  for i:=0 to FClients.Count-1 do
    TLMDPrintChangeLink(FClients[i]).Change;

  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{------------------------------------------------------------------------------}
function TLMDPrintPreviewPanel.DoMouseWheel(Shift: TShiftState;
                                            WheelDelta: Integer;
                                            MousePos: TPoint): Boolean;
var
  Delta: Integer;
  WheelClicks: Integer;
begin
  if FDestroing then
  begin
    Result := false;
    Exit;
  end;

  Result := (csDesigning in ComponentState) or
            inherited DoMouseWheel(Shift, WheelDelta, MousePos);

  if Result then
    Exit;

  if GetKeyState(VK_CONTROL) >= 0 then
  begin
    if Mouse.WheelScrollLines = Integer(WHEEL_PAGESCROLL) then
      Delta := FVScroll.LargeChange
    else
      Delta := FVScroll.SmallChange
  end
  else
    Delta := FVScroll.LargeChange;

  Inc(FMouseWheelAcc, WheelDelta);
  WheelClicks := FMouseWheelAcc div WHEEL_DELTA;
  FMouseWheelAcc := FMouseWheelAcc mod WHEEL_DELTA;

  FVScroll.Position := FVScroll.Position - (Delta * WheelClicks);
  UpdateScaleMode(pcScroll);
end;

{------------------------------------------------------------------------------}

procedure TLMDPrintPreviewPanel.DoPanelKeyDown(Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT  :
      if FHScroll.Visible then
      begin
        FHScroll.Position := FHScroll.Position - FHScroll.SmallChange;
        UpdateScaleMode(pcScroll);
      end;

    VK_RIGHT :
      if FHScroll.Visible then
      begin
        FHScroll.Position := FHScroll.Position + FHScroll.SmallChange;
        UpdateScaleMode(pcScroll);
      end;

    VK_DOWN  :
      if FVScroll.Visible then
      begin
        FVScroll.Position := FVScroll.Position + FVScroll.SmallChange;
        UpdateScaleMode(pcScroll);
      end;

    VK_UP    :
      if FVScroll.Visible then
      begin
        FVScroll.Position := FVScroll.Position - FVScroll.SmallChange;
        UpdateScaleMode(pcScroll);
      end;

    VK_PRIOR :
    begin
      if FVScroll.Visible and (FVScroll.Position > 0) then
      begin
        FVScroll.Position := FVScroll.Position - FVScroll.LargeChange;
        UpdateScaleMode(pcScroll);
      end
      else
      if CurrentPage > 0 then
      begin
        CurrentPage := CurrentPage - 1;

        if FVScroll.Visible then
          FVScroll.Position := FVScroll.Max;

        UpdateScaleMode(pcScroll);
      end;
    end;

    VK_NEXT  :
    begin
      if FPrinterHlp<>nil then
      begin
        if FVScroll.Visible and (FVScroll.Position < FVScroll.Max) then
        begin
          FVScroll.Position := FVScroll.Position + FVScroll.LargeChange;
          UpdateScaleMode(pcScroll);
        end
        else if CurrentPage < FPrinterHlp.GetPagesCount(orAll)-1 then
        begin
          CurrentPage := CurrentPage + 1;

          if FVScroll.Visible then
            FVScroll.Position := 0;

          UpdateScaleMode(pcScroll);
        end;
      end;
    end;

    VK_HOME   : if (FPrinterHlp<>nil) then
                  CurrentPage := 0;

    VK_END   : if (FPrinterHlp<>nil) then
                  CurrentPage := FPrinterHlp.GetPagesCount(orAll) - 1;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDPrintPreviewPanel.ResetVars;
begin
  FScale := 100;
  FRealScale := FScale;
  FHorzPages := 1;
  FVertPages := 1;
  FPagePanels := 1;
  FMode := pmExactScale;
  FTotalPages := 0;
  FCurrentPage := 0;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPreviewPanel.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.Resize;
begin
  if FDestroing then
    Exit;
    UpdateScaleMode(pcResize);

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.UpdateScaleMode(AChange: TLMDPrintPreviewChange);
var
  DC    : integer;

  pw, ph, x0, y0,
  i, j, idx,
  V1,
  V2    : integer;

  ScW, ScH, TextMM: Double;

  RealSize : TSize;
  RealSizeM : TSize;
  R1 : TRect;

  ScrWPx, ScrHPx, ScrWMM, ScrHMM: Double;

procedure SetScrolls;
begin
  if FHScroll.Visible then
  begin
    FHScroll.Max := RealSizeM.cx - FPaintPanel.ClientWidth;
    FHScroll.SmallChange := MulDiv(FHScroll.Max, 1, 100)+1;
    FHScroll.LargeChange := MulDiv(FHScroll.Max, 10, 100)+1;
  end;

  if FVScroll.Visible then
  begin
    FVScroll.Max := RealSizeM.cy - FPaintPanel.ClientHeight;
    FVScroll.SmallChange := MulDiv(FVScroll.Max, 1, 100)+1;
    FVScroll.LargeChange := MulDiv(FVScroll.Max, 10, 100)+1;
  end;
end;

begin
  ///////////////////
  ///  Calculations
  ///

  if (FPrinterHlp<>nil) and FHandleCreated then
  begin
    Assert(FPrinter<>nil);

    FTotalPages := FPrinterHlp.GetPagesCount(orAll);

    FPrinterFullWidthMM  := FPrinter.UnitsToUnits(FPrinter.Units,
                                                  unMillimeters,
                                                  FPrinter.PageWidthFullUnits);

    FPrinterFullHeightMM := FPrinter.UnitsToUnits(FPrinter.Units,
                                                  unMillimeters,
                                                  FPrinter.PageHeightFullUnits);
  end
  else
  begin
    FTotalPages := 0;

    FPrinterFullWidthMM  := 1;
    FPrinterFullHeightMM := 1;

    ClearPageRects;
    Exit;
  end;

  DC := GetDC(0);
  try
    ScrWPx := GetDeviceCaps(DC, HORZRES);
    ScrHPx := GetDeviceCaps(DC, VERTRES);

    ScrWMM := FPrinter.UnitsToUnits(unInches, unMillimeters,
                                    ScrWPx / GetDeviceCaps(DC, LOGPIXELSX));

    ScrHMM := FPrinter.UnitsToUnits(unInches, unMillimeters,
                                    ScrHPx / GetDeviceCaps(DC, LOGPIXELSY));

    ScW := 100 * ((ScrWMM / ScrWPx) / FPrinterFullWidthMM);
    ScH := 100 * ((ScrHMM / ScrHPx) / FPrinterFullHeightMM);

  finally
    ReleaseDC(0, DC);
  end;

  FPagePanels := 1;
  case FMode of
    pmExactScale: FRealScale := FScale;

    pmWholePage:
      FRealScale := Round(ScH * (FPaintPanel.ClientHeight - Margin * 2));

    pmTextWidth:
    begin
      TextMM := FPrinter.UnitsToUnits(FPrinter.Units, unMillimeters,
                                      FPrinter.PageWidthPrintableUnits);

      ScW := 100 * ((ScrWMM / ScrWPx) / TextMM);
      FRealScale := Round(ScW * FPaintPanel.ClientWidth);
    end;

    pmTwoPages,
    pmExactMultiPages:
    begin
      FPagePanels := FHorzPages * FVertPages;

      V1 := Round(ScW * (FPaintPanel.ClientWidth - Margin * (FHorzPages + 1)) /
                  FHorzPages);

      V2 := Round(ScH * (FPaintPanel.ClientHeight - Margin * (FVertPages + 1)) /
                  FVertPages);

      FRealScale := Min(V1, V2);
    end;
  end;

  ///////////////
  /// Changes

  ScW := FRealScale * ScrWPx / ScrWMM / 100;
  ScH := FRealScale * ScrHPx /ScrHMM / 100;

  RealSize.cx := Round(FPrinterFullWidthMM * ScW);
  RealSize.cy := Round(FPrinterFullHeightMM * ScH);

  RealSizeM.cx := RealSize.cx + Margin*2;
  RealSizeM.cy := RealSize.cy + Margin*2;

  FPagePanels := Max(0, Min(FPagePanels,
                            FPrinterHlp.GetPagesCount(orAll) - FCurrentPage));

  if AChange=pcMode then
    SetPagesNum(FPagePanels);

  for i := 0 to FPagePanels-1 do
    FPageRectsNumbers[i] := FCurrentPage + i;

  if FMode in [pmWholePage, pmTwoPages, pmExactMultiPages] then
  begin
    x0 := FPaintPanel.ClientWidth - (Margin * (FHorzPages+1)) -
          RealSize.cx * FHorzPages;
    x0 := x0 div 2;

    y0 := FPaintPanel.ClientHeight - (Margin * (FVertPages+1)) -
          RealSize.cy * FVertPages;
    y0 := y0 div 2;

    for i := 0 to FHorzPages -1 do
    begin
      for j := 0 to FVertPages - 1 do
      begin
        idx   := j * FHorzPages + i;

        R1.Left   := x0 + Margin * (i + 1) + RealSize.cx * i;
        R1.Top    := y0 + Margin * (j + 1) + RealSize.cy * j;
        R1.Right  := R1.Left + RealSize.cx;
        R1.Bottom := R1.Top + RealSize.cy;

        if idx<FPagePanels then
          FPageRects[idx] := R1;
      end;
    end;

    FHScroll.Visible := false;
    FVScroll.Visible := false;
  end
  else
  begin
    Assert(FMode in [pmExactScale, pmTextWidth]);

    FHScroll.Visible := FPaintPanel.ClientWidth < RealSizeM.cx;
    FVScroll.Visible := FPaintPanel.ClientHeight < RealSizeM.cy;

    case AChange of
      pcMode,
      pcScale:
      begin
        SetPagesNum(1);
        FPageRectsNumbers[0] := FCurrentPage;

        if FHScroll.Visible then
          x0 := Margin
        else
          x0 := Margin + ((FPaintPanel.ClientWidth - RealSizeM.cx) div 2);

        if FVScroll.Visible then
          y0 := Margin
        else
          y0 := Margin + ((FPaintPanel.ClientHeight - RealSizeM.cy) div 2);

        FPageRects[0] := Rect(x0, y0, x0 + RealSize.cx, y0 + RealSize.cy);

        SetScrolls;
        if FHScroll.Visible then
          FHScroll.Position := 0;

        if FVScroll.Visible then
          FVScroll.Position := 0;
      end;

      pcScroll:
      begin
        if FHScroll.Visible then
        begin
          pw := FPageRects[0].Right - FPageRects[0].Left;

          FPageRects[0].Left := Margin - FHScroll.Position;
          FPageRects[0].Right := FPageRects[0].Left + pw;
        end;

        if FVScroll.Visible then
        begin
          ph := FPageRects[0].Bottom - FPageRects[0].Top;

          FPageRects[0].Top := Margin - FVScroll.Position;
          FPageRects[0].Bottom := FPageRects[0].Top + ph;
        end;
      end;

      pcCurrentPage:  FPageRectsNumbers[0] := FCurrentPage;

      pcResize:
      begin
        x0 := FPaintPanel.ClientWidth - RealSizeM.cx;
        x0 := x0 div 2;

        ///
        if x0>=0 then
          FPageRects[0].Left := x0 + Margin
        else if FPageRects[0].Left > Margin then
          FPageRects[0].Left := Margin;

        FPageRects[0].Right := FPageRects[0].Left + RealSize.cx;
        ///

        y0 := FPaintPanel.ClientHeight - RealSizeM.cy;
        y0 := y0 div 2;

        ///
        if y0>=0 then
          FPageRects[0].Top := y0 + Margin
        else if FPageRects[0].Top > Margin then
          FPageRects[0].Top := Margin;

        FPageRects[0].Bottom := FPageRects[0].Top + RealSize.cy;
        ///

        if ((FPageRects[0].Right - FPageRects[0].Left) <> RealSize.cx) then
          Assert(false);

        if ((FPageRects[0].Bottom - FPageRects[0].Top) <> RealSize.cy) then
          Assert(false);

        SetScrolls;
      end;

      else
        Assert(false);
    end;
  end;

  FBmp.Width := FPaintPanel.ClientWidth;
  FBmp.Height := FPaintPanel.ClientHeight;

  FPaintPanel.Invalidate;

  if AChange in [pcMode, pcScale, pcCurrentPage] then
    Change;
end;

{--------------------------- public -------------------------------------------}

procedure TLMDPrintPreviewPanel.CheckPrinterAssigned;
begin
  if not Assigned(FPrinterHlp) then
    raise ELMDPrintPackError.Create(SLMDPrintPrinterNotAssigned);
end;

{--------------------------- public -------------------------------------------}

constructor TLMDPrintPreviewPanel.Create(AOwner: TComponent);
begin
  inherited;

  FMouseWheelAcc := 0;
  FDestroing := false;
  FHandleCreated := false;

  ControlStyle := ControlStyle-[csAcceptsControls];
  Color := clBtnShadow;

  DoubleBuffered := true;

  FBmp := Graphics.TBitmap.Create;

  FHScroll := TScrollBar.Create(self);
  FHScroll.Parent := self;
  FHScroll.Kind := sbHorizontal;
  FHScroll.Align := alBottom;
  FHScroll.OnChange := ScrollChange;
  FHScroll.TabStop := false;
  FHScroll.DoubleBuffered := true;

  FVScroll := TScrollBar.Create(self);
  FVScroll.Parent := self;
  FVScroll.Kind := sbVertical;
  FVScroll.Align := alRight;
  FVScroll.OnChange := ScrollChange;
  FVScroll.TabStop := false;
  FVScroll.DoubleBuffered := true;

  FPaintPanel := TMyPaintPanel.Create(self);
  FPaintPanel.Parent := self;
  FPaintPanel.Align := alClient;
  FPaintPanel.TabStop := true;
  FPaintPanel.Visible := true;
  FPaintPanel.DoubleBuffered := true;

  ResetVars;

  FClients := TList.Create;

  FPrinter := nil;
  FPrinterHlp := nil;

  FMargin := LMDPrintPreviewDefaultMargin;

  FLst := THelperLst.Create(self);

  UpdateScaleMode(pcMode);
end;

{------------------------------------------------------------------------------}
destructor TLMDPrintPreviewPanel.Destroy;
begin
  FDestroing := true;

  while FClients.Count > 0 do
    UnRegisterChanges(TLMDPrintChangeLink(FClients.Last));

  FreeAndNil(FClients);

  SetPrinterHelper(nil);
  FLst.Free;

  FreeAndNil(FPaintPanel);
  FreeAndNil(FHScroll);
  FreeAndNil(FHScroll);

  FreeAndNil(FBmp);

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.RegisterChanges(AValue: TLMDPrintChangeLink);
begin
  if not Assigned(AValue) then
    Exit;

  AValue.Sender:= Self;
  FClients.Add(AValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.UnRegisterChanges(AValue: TLMDPrintChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
  begin
    for i:= 0 to FClients.Count - 1 do
      if FClients[I] = AValue then
      begin
        AValue.Sender := nil;
        FClients.Delete(I);
        Break;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.SetMargin(AValue: Integer);
begin
  if FMargin=AValue then
    Exit;

  if AValue<0 then
    raise ELMDPrintPackError.Create(SLMDPrintPvBadMarginArg);

  FMargin := AValue;

  UpdateScaleMode(pcResize);
end;

procedure TLMDPrintPreviewPanel.SetMode(AValue: TLMDPrintPreviewMode);
begin
  if FMode=AValue then
    Exit;

  FMode := AValue;

  case FMode of
    pmExactScale,
    pmWholePage,
    pmTextWidth:
    begin
      FHorzPages := 1;
      FVertPages := 1;
    end;

    pmTwoPages:
    begin
      FHorzPages := 2;
      FVertPages := 1;
    end;

    pmExactMultiPages: ;

  else
    Assert(false);
  end;

  UpdateScaleMode(pcMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDPrintPreviewPanel.SetMultiPages(AHorzPages, AVertPages: Integer;
                                              ADoChangeMode: Boolean);
begin
  if (FHorzPages=AHorzPages) and (FVertPages=AVertPages) then
    Exit;

  FHorzPages := AHorzPages;
  FVertPages := AVertPages;

  if ADoChangeMode and (FMode<>pmExactMultiPages) then
    SetMode(pmExactMultiPages)
  else
    UpdateScaleMode(pcMode);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPreviewPanel.Zoom(AZoomIn: Boolean);
var
  i: Integer;
  Ok: Boolean;
begin
  Ok := false;

  if AZoomIn then
  begin
    for i := High(LMDPrintZoomValues) downto Low(LMDPrintZoomValues) do
      if Scale < LMDPrintZoomValues[i] then
      begin
        Scale := LMDPrintZoomValues[i];
        Ok := true;

        Break;
      end;

    if not Ok then
      Scale := LMDPrintZoomValues[Low(LMDPrintZoomValues)];
  end
  else
  begin
    for i := Low(LMDPrintZoomValues) to High(LMDPrintZoomValues)-1 do
      if Scale > LMDPrintZoomValues[i] then
      begin
        Scale := LMDPrintZoomValues[i];
        Ok := true;

        Break;
      end;

    if not Ok then
      Scale := LMDPrintZoomValues[High(LMDPrintZoomValues)];
  end;
end;

{ THelperLst }

constructor THelperLst.Create(APanel: TLMDPrintPreviewPanel);
begin
  inherited Create;

  FPanel := APanel;
end;

procedure THelperLst.Refresh(AChanges: TLMDPrinterChangeKinds);
var
    OldMode: TLMDPrintPreviewMode;
begin
  OldMode := FPanel.FMode;
  FPanel.ResetVars;

  if OldMode in [pmExactScale, pmWholePage, pmTextWidth] then
    FPanel.FMode := OldMode
  else
    FPanel.FMode := pmExactScale;

  FPanel.UpdateScaleMode(pcMode);
end;

procedure TLMDPrintPreviewPanel.ClearPageRects;
begin
  SetLength(FPageRects, 0);
  SetLength(FPageRectsNumbers, 0);
end;

procedure TLMDPrintPreviewPanel.SetPagesNum(ANum: Integer);
var i: Integer;
begin
  SetLength(FPageRects, ANum);
  SetLength(FPageRectsNumbers, ANum);

  for i:=0 to ANum-1 do
  begin
    FPageRects[i] := Rect(-1, -1, -1, -1);
    FPageRectsNumbers[i] := -1;
  end;
end;

procedure TLMDPrintPreviewPanel.ScrollChange(ASender: TObject);
begin
  UpdateScaleMode(pcScroll);
end;

{ TMyPaintPanel }

constructor TMyPaintPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FParent := AOwner as TLMDPrintPreviewPanel;

  ControlStyle := ControlStyle + [csDoubleClicks, csOpaque];
end;

procedure TMyPaintPanel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  FParent.DoPanelKeyDown(Key, Shift);
end;

procedure TMyPaintPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  Windows.SetFocus(Handle);
end;

procedure TMyPaintPanel.Paint;
begin
  FParent.PaintContent;
end;

procedure TMyPaintPanel.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TLMDPrintPreviewPanel.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  ClassStylesOff = CS_VREDRAW or CS_HREDRAW;
begin
  Assert(not FDestroing);

  inherited CreateParams(Params);

  with Params do
  begin
    WindowClass.Style := WindowClass.Style and not ClassStylesOff;
    Style := Style or WS_CLIPCHILDREN;
  end;
end;

procedure TLMDPrintPreviewPanel.CreateWindowHandle(const Params: TCreateParams);
begin
  Assert(not FDestroing);
  inherited;

  FHandleCreated := true;

  UpdateScaleMode(pcMode);
end;

procedure TLMDPrintPreviewPanel.DestroyWindowHandle;
begin
  FHandleCreated := false;
  if not FDestroing then
    UpdateScaleMode(pcMode);

  inherited;
end;

end.
