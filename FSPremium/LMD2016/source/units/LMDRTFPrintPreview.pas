unit LMDRTFPrintPreview;
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

LMDRTFPrintPreview unit ()
--------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ImgList, StdCtrls, Buttons,
  LMDRTFRichEdit, LMDTypes;

type
{ **************************  TfrmPrintPreview  *************************** }
  TLMDRichfrmPrintPreview = class(TForm)
    ToolBar1: TToolBar;
    btnPrint: TToolButton;
    ToolButton2: TToolButton;
    btnFullPage: TToolButton;
    btnFitPage: TToolButton;
    ToolButton6: TToolButton;
    btnExit: TToolButton;
    ImageList: TImageList;
    ScrollBox: TScrollBox;
    btnPageProps: TToolButton;
    ToolButton3: TToolButton;
    btnRealSize: TToolButton;
    VScrollBar: TScrollBar;
    btnExtendedPreview: TToolButton;
    HScrollBar: TScrollBar;
    btnPrev: TSpeedButton;
    btnLast: TSpeedButton;
    btnFirst: TSpeedButton;
    btnNext: TSpeedButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnFullPageClick(Sender: TObject);
    procedure btnFitPageClick(Sender: TObject);
    procedure btnPagePropsClick(Sender: TObject);
    procedure btnRealSizeClick(Sender: TObject);
    procedure VScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure btnExtendedPreviewClick(Sender: TObject);
    procedure HScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
  private
    { Private declarations }
    FPages: TList;
    FRichEdit: TLMDCustomRichEdit;
    FLastArrange: LongInt;

    FVPrevScrollPos : integer;
    FHPrevScrollPos : integer;    

    FExtendedMode : boolean;
    FColCount : integer;
    FRowCount : integer;

    procedure ShowPages(aScrollPosition : integer; aVisible : boolean);
  public
    { Public declarations }
    constructor Create(aOnwer: TComponent); override;
    destructor Destroy; override;
    procedure ArrangePages(aType: LongInt);
    procedure ArrangePagesEx(aRowCount, aColCount : LongInt);
    class function Execute(aRichEdit: TLMDCustomRichEdit): Boolean;
  end;

implementation

uses ExtCtrls, Printers, LMDRTFBase, LMDRTFPrintPreviewMode;

{$R *.DFM}

type
  TPreviewPage = class(TPaintBox)
  private
    FPageScale: Extended;
    FStartChar: Longint;
    FLastChar: Longint;
    FLogX, FLogY: LongInt;
    procedure SetPageScale(const Value: Extended);
  protected
    procedure Paint; override;
  public
    constructor Create(aOwner: TComponent; aStartChar: LongInt); reintroduce;
    property PageScale: Extended read FPageScale write SetPageScale;
    property LastChar: Longint read FLastChar;
  end;

{ ***************************** TPreviewPage  ***************************** }
{ ------------------------------------------------------------------------- }

constructor TPreviewPage.Create(aOwner: TComponent; aStartChar: Integer);
var
//  LogX, LogY: Integer;
  B: TBitmap;
begin
  inherited Create(aOwner);
  Parent:= aOwner as TWinControl;
  FPageScale:= 1;
  FLogX:= GetDeviceCaps(Printer.Handle, LOGPIXELSX) div GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
  FLogY:= GetDeviceCaps(Printer.Handle, LOGPIXELSY) div GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  Width:= Printer.PageWidth div FLogX + 7;
  Height:= Printer.PageHeight div FLogY + 7;
  FStartChar:= aStartChar;
  FLastChar:= aStartChar;
  B:= TBitmap.Create;
  try
    B.Width:= Width;
    B.Height:= Height;
    TLMDRichfrmPrintPreview(aOwner.Owner).FRichEdit.Preview(B.Canvas, false, FLastChar);
  finally
    B.Free;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TPreviewPage.Paint;
var
  R: TRect;
  B1: TMetafile;
  B2: TMetafileCanvas;
  U: TLMDMeasurement;
begin
  inherited;
  R:= ClientRect;
  Dec(R.Right, 5);
  Dec(R.Bottom, 5);
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(R);
  Canvas.Rectangle(R);
  InflateRect(R, -1, -1);
  FLastChar:= FStartChar;
  B1:= TMetafile.Create;
  U:= TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.Measurement;
  TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.Measurement:= unPoints;
  try
    B1.Width:= Trunc((Width - 7) / FPageScale);
    B1.Height:= Trunc((Height - 7) / FPageScale);
    B2:= TMetafileCanvas.Create(B1, Canvas.Handle);
    TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.Preview(B2, true, FLastChar);
    B2.Pen.Style:= psDash;
    B2.Pen.Color:= clGray;
    B2.MoveTo(Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Left * 4
      / 3) { div FLogX}, 0);
    B2.LineTo(Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Left * 4
      / 3) { div FLogX},
      Trunc((Height - 7) / FPageScale));

    B2.MoveTo(Trunc((Width - 7) / FPageScale) -
      Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Right * 4 / 3)
        {div FLogX}, 0);
    B2.LineTo(Trunc((Width - 7) / FPageScale) -
      Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Right * 4 / 3)
        {div FLogX},
      Trunc((Height - 7) / FPageScale));

    B2.MoveTo(0, Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Top *
      4 / 3) {div FLogY});
    B2.LineTo(Trunc((Width - 7) / FPageScale),
      Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Top * 4 / 3)
        {div FLogY});

    B2.MoveTo(0, Trunc((Height - 7) / FPageScale) -
      Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Bottom * 4 / 3)
        {div FLogY});
    B2.LineTo(Trunc((Width - 7) / FPageScale),
      Trunc((Height - 7) / FPageScale) -
      Trunc(TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.PageMargins.Bottom * 4 / 3)
        {div FLogY});

    B2.Free;
    Canvas.StretchDraw(R, B1);
  finally
    B1.Free;
    TLMDRichfrmPrintPreview(Owner.Owner).FRichEdit.Measurement:= U;
  end;
  R:= ClientRect;
  R.Left:= R.Right - 5;
  R.Top:= R.Top + 5;
  Canvas.Brush.Color:= clBlack;
  Canvas.FillRect(R);
  R.Bottom:= R.Top;
  R.Top:= R.Top - 5;
  Canvas.Brush.Color:= clGray;
  Canvas.FillRect(R);

  R:= ClientRect;
  R.Left:= R.Left + 5;
  R.Top:= R.Bottom - 5;
  Canvas.Brush.Color:= clBlack;
  Canvas.FillRect(R);
  R.Right:= R.Left;
  R.Left:= R.Left - 5;
  Canvas.Brush.Color:= clGray;
  Canvas.FillRect(R);
end;

{ ------------------------------------------------------------------------- }

procedure TPreviewPage.SetPageScale(const Value: Extended);
var
  LogX, LogY: Integer;
begin
  if FPageScale <> Value then
    begin
      FPageScale:= Value;
      LogX:= GetDeviceCaps(Printer.Handle, LOGPIXELSX) div
        GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
      LogY:= GetDeviceCaps(Printer.Handle, LOGPIXELSY) div
        GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
      Width:= Trunc(Printer.PageWidth div LogX * FPageScale) + 7;
      Height:= Trunc(Printer.PageHeight div LogY * FPageScale) + 7;
    end;
end;

{ *************************** TLMDRichfrmPrintPreview  *************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDRichfrmPrintPreview.Create(aOnwer: TComponent);
begin
  inherited;
  FPages:= TList.Create;
  FExtendedMode := False;
  FColCount := 1;
  FRowCount := 1;
end;

{ ------------------------------------------------------------------------- }

destructor TLMDRichfrmPrintPreview.Destroy;
begin
  FreeAndNil(FPages);
  inherited;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.FormResize(Sender: TObject);
begin
  ArrangePages(FLastArrange)
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnPrintClick(Sender: TObject);
begin
  ModalResult:= mrYes
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnPagePropsClick(Sender: TObject);
var
  I: LongInt;
  old:TLMDRichDialogPosition;
begin
  // do not bring main form to front
  old:=FRichEdit.DlgPosition;
  FRichEdit.DlgPosition:=rdpScreen;
  try
    if FRichEdit.PagePropertiesDialog then
      begin
        for I:= 0 to FPages.Count - 1 do
          TPreviewPage(FPages[I]).Free;
        FPages.Clear;
        I:= 0;
        repeat
          FPages.Add(TPreviewPage.Create(ScrollBox, I));
          I:= TPreviewPage(FPages[FPages.Count - 1]).LastChar;
          TPreviewPage(FPages[FPages.Count - 1]).Visible:= false;
        until (I = -1) or (I = 0);
        ArrangePages(FLastArrange);
      end;
   finally
    FRichEdit.DlgPosition:=old;
   end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnFullPageClick(Sender: TObject);
begin
  FLastArrange:= 0;
  ArrangePages(FLastArrange)
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnFitPageClick(Sender: TObject);
begin
  FLastArrange:= 1;
  ArrangePages(FLastArrange)
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnRealSizeClick(Sender: TObject);
begin
  FLastArrange:= 2;
  ArrangePages(FLastArrange)
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.btnExitClick(Sender: TObject);
begin
  ModalResult:= mrCancel
end;

{ ------------------------------------------------------------------------- }

class function TLMDRichfrmPrintPreview.Execute(aRichEdit: TLMDCustomRichEdit): Boolean;
var
  T: TLMDRichfrmPrintPreview;
  I: LongInt;
begin
  Result := False;
  if not Assigned(aRichEdit) then exit;
  T:= Create(aRichEdit);
  try
    T.FRichEdit:= aRichEdit;
    I:= 0;
    repeat
      T.FPages.Add(TPreviewPage.Create(T.ScrollBox, I));
      I:= TPreviewPage(T.FPages[T.FPages.Count - 1]).LastChar;
      TPreviewPage(T.FPages[T.FPages.Count - 1]).Visible:= false;
    until (I = -1) or (I = 0);
    T.FLastArrange:= 0;
    T.FExtendedMode := False;
    T.FColCount := 1;
    T.FRowCount := 1;
    T.ArrangePages(T.FLastArrange);

    aRichEdit.PrepareDialog(t);

    Result:= T.ShowModal = mrYes;

    if Result then
      aRichEdit.Print('');

    for I:= 0 to T.FPages.Count - 1 do
      TPreviewPage(T.FPages[I]).Free;
  finally
    T.Free;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmPrintPreview.ArrangePages(aType: LongInt);
var
  I: LongInt;
  LogX, LogY: LongInt;
begin
  i := 0;
  VScrollBarScroll(self, scPosition, i);

  FExtendedMode := False;

  LogX:= GetDeviceCaps(Printer.Handle, LOGPIXELSX) div
    GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
  LogY:= GetDeviceCaps(Printer.Handle, LOGPIXELSY) div
    GetDeviceCaps(Canvas.Handle, LOGPIXELSY);

  case aType of
    0:
      for I:= 0 to FPages.Count - 1 do
        begin
          TPreviewPage(FPages[I]).PageScale:= (ScrollBox.Height - 30) * LogY /
            Printer.PageHeight;
          TPreviewPage(FPages[I]).Left:= (ScrollBox.Width -
            TPreviewPage(FPages[I]).Width) div 2;
          if TPreviewPage(FPages[I]).Width > Width - 40 then
            Width:= TPreviewPage(FPages[I]).Width + 40;
          TPreviewPage(FPages[I]).Top:= TPreviewPage(FPages[I]).Height * I + 10
            * (I + 1);
          TPreviewPage(FPages[I]).Visible:= true;
        end;
    1:
      for I:= 0 to FPages.Count - 1 do
        begin
          TPreviewPage(FPages[I]).PageScale:= (ScrollBox.Width - 40) * LogX /
            Printer.PageWidth;
          TPreviewPage(FPages[I]).Left:= 10;
          TPreviewPage(FPages[I]).Top:= TPreviewPage(FPages[I]).Height * I + 10
            * (I + 1);
          TPreviewPage(FPages[I]).Visible:= true;
        end;
    2:
      for I:= 0 to FPages.Count - 1 do
        begin
          TPreviewPage(FPages[I]).PageScale:= 1;
          TPreviewPage(FPages[I]).Left:= 10;
          TPreviewPage(FPages[I]).Top:= TPreviewPage(FPages[I]).Height * I + 10
            * (I + 1);
          TPreviewPage(FPages[I]).Visible:= true;
        end;
  end;

  if FPages.count > 0 then
    begin
      VScrollBar.Max := TPreviewPage(FPages[FPages.count-1]).Top;
      if TPreviewPage(FPages[FPages.count-1]).Height > Height then
        VScrollBar.Max := VScrollBar.Max + TPreviewPage(FPages[FPages.count-1]).Height - Height + 80;
      VScrollBar.Position := 0;
      VScrollBar.LargeChange := TPreviewPage(FPages[0]).Height;
      VScrollBar.SmallChange := 8;

      if TPreviewPage(FPages[0]).Width > Width then
        begin
          HScrollBar.Max := TPreviewPage(FPages[0]).Width - Width+50;
          HScrollBar.Position := 0;
          HScrollBar.LargeChange := 8;
          HScrollBar.SmallChange := 8;
          FHPrevScrollPos := 0;
        end
      else
        begin
          HScrollBar.Max := 0;
          HScrollBar.Position := 0;
          HScrollBar.LargeChange := 1;
          HScrollBar.SmallChange := 1;
          FHPrevScrollPos := 0;
        end;
    end;
end;

procedure TLMDRichfrmPrintPreview.ArrangePagesEx(aRowCount, aColCount : LongInt);
var
  I             : LongInt;
  LogX          : LongInt;
  LogY          : LongInt;
  ScaleH        : extended;
  ScaleW        : extended;
  Scale         : extended;
  StartXOffset  : integer;
  StartYOffset  : integer;
//  h             : integer;
//  hw            : LongInt;
  hh            : LongInt;
  XOffset       : LongInt;
  YOffset       : LongInt;
  Row, Col      : LongInt;
begin
  hh := 0;
  if (aRowCount = 0) or (aColCount = 0) then Exit;

  FExtendedMode := True;

  //h := 10;
  LogX:= GetDeviceCaps(Printer.Handle, LOGPIXELSX) div GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
  LogY:= GetDeviceCaps(Printer.Handle, LOGPIXELSY) div GetDeviceCaps(Canvas.Handle, LOGPIXELSY);

  ScaleH := (ScrollBox.Height - 50 - aRowCount*2) * LogY / (Printer.PageHeight*aRowCount);
  ScaleW := (ScrollBox.Width - 50 - aColCount*2) * LogX / (Printer.PageWidth*aColCount);

  if ScaleH < ScaleW then
    Scale := ScaleH
  else
    Scale := ScaleW;

  i := 0;
  StartXOffset := 2;
  StartYOffset := 2;
  if FPages.Count > 0 then
  begin
    TPreviewPage(FPages[0]).PageScale := Scale;
    StartXOffset := Trunc((Width-40- aColCount*2 -(TPreviewPage(FPages[0]).width*aColCount))/2);
    StartYOffset := Trunc((Height-50- aRowCount*2  - (TPreviewPage(FPages[0]).height*aRowCount))/2);
  end;

  YOffset := StartYOffset;
  while i < FPages.Count do
    begin
      for Row := 1 to aRowCount do
        begin
          XOffset := StartXOffset;
          for Col := 1 to aColCount do
            begin
              TPreviewPage(FPages[I]).PageScale:= Scale;
              TPreviewPage(FPages[I]).Left:= XOffset;
              TPreviewPage(FPages[I]).Top:= YOffset;
              TPreviewPage(FPages[I]).Visible:= False;
              XOffset := XOffset + TPreviewPage(FPages[I]).width + 2;
              hh := TPreviewPage(FPages[I]).height;
              inc(i);
              if i >= FPages.Count then Break;
            end;
            if i >= FPages.Count then Break;            
            YOffset := YOffset + hh + 2;
        end;
        YOffset := StartYOffset;
      end;

  if FPages.count > 0 then
    begin
      VScrollBar.Max := Trunc(FPages.count/(aRowCount*aColCount));
      VScrollBar.Position := 0;
      VScrollBar.LargeChange := 1;
      VScrollBar.SmallChange := 1;
      FVPrevScrollPos := -1;
    end;

  i := 0;
  VScrollBarScroll(self, scPosition, i);
end;

procedure TLMDRichfrmPrintPreview.ShowPages(aScrollPosition : integer; aVisible : boolean);
var
  i             : integer;
  StartPage     : integer;
  EndPage       : integer;
begin
  if FPages.Count = 0 then Exit;

  StartPage := aScrollPosition*FRowCount*FColCount;
  EndPage := StartPage + FRowCount*FColCount - 1;

  if (StartPage >= FPages.Count) or (StartPage < 0) then Exit;
  if EndPage >= FPages.count then EndPage := FPages.count-1;

  for i := StartPage to EndPage do
    TPreviewPage(FPages[I]).Visible:= aVisible;
end;

procedure TLMDRichfrmPrintPreview.VScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if not FExtendedMode then
    begin
      ScrollBox.ScrollBy(0, FVPrevScrollPos-ScrollPos);
      FVPrevScrollPos := ScrollPos;
    end
  else
    if FVPrevScrollPos <> ScrollPos then
      begin
        ShowPages(FVPrevScrollPos, False);
        ShowPages(ScrollPos, True);
        FVPrevScrollPos := ScrollPos;
      end;
end;

procedure TLMDRichfrmPrintPreview.btnExtendedPreviewClick(Sender: TObject);
var
  P : TPoint;
begin
  with TRTFPrintPreviewMode.Create(nil) do
    begin
    P := Point(btnExtendedPreview.Left, btnExtendedPreview.Top + btnExtendedPreview.Height);
    P := ToolBar1.ClientToScreen(P);
      Left := P.x;
      Top := P.y;
      if ShowModal = mrOk then
      begin
        FRowCount := RowCount;
        FColCount := ColCount;
        ArrangePagesEx(FRowCount,FColCount);
      end;
      Free;
    end;
end;

procedure TLMDRichfrmPrintPreview.HScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if not FExtendedMode then
    begin
      ScrollBox.ScrollBy(FHPrevScrollPos-ScrollPos, 0);
      FHPrevScrollPos := ScrollPos;
    end;
end;

procedure TLMDRichfrmPrintPreview.btnFirstClick(Sender: TObject);
var
  i : integer;
begin
  i := 0;
  if FExtendedMode then
    begin
      VScrollBarScroll(self, scPosition, i);
      VScrollBar.Position := i;
    end;
end;

procedure TLMDRichfrmPrintPreview.btnPrevClick(Sender: TObject);
var
  i : integer;
begin
  i := VScrollBar.Position-1;
  if i < VScrollBar.Min then Exit;
  if FExtendedMode then
    begin
      VScrollBarScroll(self, scPosition, i);
      VScrollBar.Position := i;
    end;
end;

procedure TLMDRichfrmPrintPreview.btnNextClick(Sender: TObject);
var
  i : integer;
begin
  i := VScrollBar.Position+1;
  if i > VScrollBar.Max then Exit;  
  if FExtendedMode then
    begin
      VScrollBarScroll(self, scPosition, i);
      VScrollBar.Position := i;
    end;
end;

procedure TLMDRichfrmPrintPreview.btnLastClick(Sender: TObject);
var
  i : integer;
begin
  i := VScrollBar.Max;
  if FExtendedMode then
    begin
      VScrollBarScroll(self, scPosition, i);
      VScrollBar.Position := i;
    end;
end;

end.
