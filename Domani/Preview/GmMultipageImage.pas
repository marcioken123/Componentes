{******************************************************************************}
{                                                                              }
{                       GmMultipageImage.pas v2.61 Pro                         }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmMultipageImage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  GmPreview, Buttons, GmTypes, GmConst;

  {$I GMPS.INC}

type
  TGmMultiPrintPage = class(TGmPaperImage)
  private
    FOrientation: TGmOrientation;
    FPagesPerSheet: TGmPagesPerSheet;
    FShowHeaderFooter: Boolean;
    procedure SetPagesPerSheet(APagesPerSheet: TGmPagesPerSheet);
    procedure DrawHeaderFooter(Canvas: TCanvas; AArea: TRect; Border: integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PagesPerSheet: TGmPagesPerSheet read FPagesPerSheet write SetPagesPerSheet default gmFourPage;
  end;


  TGmMultipageImage = class(TWinControl)
  private
    FBorderStyle: TBorderStyle;
    FBtnOnePage : TSpeedButton;
    FBtnTwoPage : TSpeedButton;
    FBtnFourPage: TSpeedButton;
    FPagesPerSheet: TGmPagesPerSheet;
    FPreview: TGmPreview;
    FPageImage: TGmMultiPrintPage;
    FShowButtons: Boolean;
    FShowHeaderFooter: Boolean;
    // events...
    FOnClickOnePage : TNotifyEvent;
    FOnClickTwoPage : TNotifyEvent;
    FOnClickFourPage: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    function GetAbout: string;
    function GetVersion: Extended;
    procedure SetAbout(const AValue: string);
    procedure BtnClick(Sender: TObject);
    procedure SetPreview(APreview: TGmPreview);
    procedure SetPagesPerSheet(APagesPerSheet: TGmPagesPerSheet);
    procedure SetShadow(AShadow: TGmShadow);
    procedure SetShowButtons(AValue: Boolean);
    procedure SetShowHeaderFooter(AValue: Boolean);
    function GetShadow: TGmShadow;
    procedure SetBorderStyle(const Value: TBorderStyle);

    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // update messages...
    procedure MultiPageChanged(var Message: TMessage); message GM_MULTIPAGE_CHANGED;
    procedure OrientationChanged(var Message: TMessage); message GM_ORIENTATION_CHANGED;
    procedure ComponentResize(var Message: TMessage); message WM_SIZE;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Version: Extended read GetVersion;
    { Public declarations }
  published
    property About: string read GetAbout write SetAbout;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color default clGray;
    property Hint;
    property PagesPerSheet: TGmPagesPerSheet read FPagesPerSheet write SetPagesPerSheet default gmOnePage;
    property ParentColor;
    property Preview: TGmPreview read FPreview write SetPreview;
    property ShowHint;
    property Shadow: TGmShadow read GetShadow write SetShadow;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons default True;
    property ShowHeaderFooter: Boolean read FShowHeaderFooter write SetShowHeaderFooter default True;
    property TabOrder;
    property Visible;
    // enents...
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property OnClickOnePage: TNotifyEvent read FOnClickOnePage write FOnClickOnePage;
    property OnClickTwoPage: TNotifyEvent read FOnClickTwoPage write FOnClickTwoPage;
    property OnClickFourPage: TNotifyEvent read FOnClickFourPage write FOnClickFourPage;
    { Published declarations }
  end;

implementation

{$R MultiRes.RES}

//------------------------------------------------------------------------------

constructor TGmMultiPrintPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Shadow := TGmShadow.Create;
  Gutter := 5;
  FPagesPerSheet := gmFourPage;
end;

destructor TGmMultiPrintPage.Destroy;
begin
  Shadow.Free;
  inherited Destroy;
end;

procedure TGmMultiPrintPage.SetPagesPerSheet(APagesPerSheet: TGmPagesPerSheet);
var
  AHeight: integer;
  AWidth: integer;
begin
  if FOrientation = gmPortrait then
  begin
    AHeight := 65;
    AWidth := 50;
  end
  else
  begin
    AHeight := 50;
    AWidth := 65;
  end;
  FPagesPerSheet := APagesPerSheet;
  // resize page...
  if FPagesPerSheet = gmTwoPage then
  begin
    Height := AWidth;
    Width := AHeight;
  end
  else
  begin
    Height := AHeight;
    Width := AWidth;
  end;
  Top := (TWinControl(Owner).Height - Height) div 2;
  Invalidate;
end;

procedure TGmMultiPrintPage.DrawHeaderFooter(Canvas: TCanvas; AArea: TRect; Border: integer);
begin
  if FShowHeaderFooter then
  begin
    Canvas.Pen.Color := clSilver;
    Canvas.Pen.Style := psSolid;
    Canvas.Polyline([Point(AArea.Left+Border, AArea.Top+Border+1)   , Point(AArea.Right-Border, AArea.Top+Border+1)]);
    Canvas.Polyline([Point(AArea.Left+Border, AArea.Bottom-Border-1), Point(AArea.Right-Border, AArea.Bottom-Border-1)]);
  end;
end;

procedure TGmMultiPrintPage.Paint;
var
  PageArea: TRect;
  PageRects: array[1..4] of TRect;
begin
  // paint the page...
  inherited;
  Canvas.Pen.Style := psSolid;
  PageArea := PageRect;
  if FPagesPerSheet = gmOnePage then
    DrawHeaderFooter(Canvas, PageArea, 6)
  else
  if FPagesPerSheet = gmTwoPage then
  begin

    if FOrientation = gmPortrait then
    begin
      PageRects[1] := Rect(PageArea.Left, PageArea.Top, (Width div 2), Height - PageArea.Top);
      PageRects[2] := Rect((Width div 2), PageArea.Top, Width - PageArea.Left, Height - PageArea.Top);
      Canvas.Pen.Color := clGray;
      Canvas.Polyline([Point(PageRects[1].Right, PageRects[1].Top),
                       Point(PageRects[1].Right, PageRects[1].Bottom)]);
    end;
    if FOrientation = gmLandscape then
    begin
      PageRects[1] := Rect(PageArea.Left, PageArea.Top, Width - PageArea.Left, Height div 2);
      PageRects[2] := Rect(PageArea.Left, Height div 2, Width - PageArea.Left, Height - PageArea.Top);
      Canvas.Pen.Color := clGray;
      Canvas.Polyline([Point(PageRects[1].Left+1,PageRects[1].Bottom),
                       Point(PageRects[1].Right-1,PageRects[1].Bottom)]);
    end;
    DrawHeaderFooter(Canvas, PageRects[1], 4);
    DrawHeaderFooter(Canvas, PageRects[2], 4);
  end
  else
  if FPagesPerSheet = gmFourPage then
  begin
    PageRects[1] := Rect(PageArea.Left, PageArea.Top, (Width div 2), Height div 2);
    PageRects[2] := Rect((Width div 2), PageArea.Top, Width - PageArea.Left, Height div 2);
    PageRects[3] := Rect(PageArea.Left, PageRects[1].Bottom, (Width div 2), PageArea.Bottom);
    PageRects[4] := Rect(Width div 2, PageRects[1].Bottom, Width - PageArea.Left, PageArea.Bottom);
    Canvas.Pen.Color := clGray;
    Canvas.Polyline([Point(PageRects[1].Right, PageRects[1].Top),
                     Point(PageRects[1].Right, PageRects[3].Bottom)]);
    Canvas.Polyline([Point(PageRects[1].Left, PageRects[1].Bottom),
                     Point(PageRects[2].Right, PageRects[1].Bottom)]);
    Canvas.Pen.Color := clBlack;
    DrawHeaderFooter(Canvas, PageRects[1], 4);
    DrawHeaderFooter(Canvas, PageRects[2], 4);
    DrawHeaderFooter(Canvas, PageRects[3], 4);
    DrawHeaderFooter(Canvas, PageRects[4], 4);
  end;
end;

//------------------------------------------------------------------------------


constructor TGmMultipageImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderStyle := bsSingle;
  Color := clGray;
  Width := 121;
  Height := 89;
  FPageImage := TGmMultiPrintPage.Create(Self);
  FPageImage.FShowHeaderFooter := True;

  FShowHeaderFooter := True;
  with FPageImage do
  begin
    Left := 40;
    Width := 45;
    Height := 60;
    Shadow.Width := 2;
    PaperSize := A4;
    Parent := Self;
  end;
  FShowButtons := False;
  PagesPerSheet := gmOnePage;
  SetShowButtons(True);
end;

destructor TGmMultipageImage.Destroy;
begin
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  // free the TGmMultipageImage and destroy...
  if Assigned(FBtnOnePage) then FBtnOnePage.Free;
  if Assigned(FBtnTwoPage) then FBtnTwoPage.Free;
  if Assigned(FBtnFourPage) then FBtnFourPage.Free;
  FPageImage.Free;
  inherited Destroy;
end;

function TGmMultipageImage.GetAbout: string;
begin
  Result := Self.ClassName+' v'+FloatToStr(GetVersion);
end;

function TGmMultipageImage.GetVersion: Extended;
begin
  Result := SUITE_VERSION;
end;

procedure TGmMultipageImage.SetAbout(const AValue: string);
begin
  // does nothing.
end;

procedure TGmMultipageImage.CreateParams(var Params: TCreateParams);
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

procedure TGmMultipageImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
    FPreview := nil;
end;

procedure TGmMultipageImage.MultiPageChanged(var Message: TMessage);
begin
  if PagesPerSheet <> FPreview.PagesPerSheet then
    PagesPerSheet := FPreview.PagesPerSheet;
end;

procedure TGmMultiPageImage.OrientationChanged(var Message: TMessage);
begin
  SetPagesPerSheet(FPagesPerSheet);
end;

procedure TGmMultiPageImage.ComponentResize(var Message: TMessage);
begin
  FBtnOnePage.SetBounds((Width div 2) - 44, (Height div 2) - 38, FBtnOnePage.Width, FBtnOnePage.Height);
  FBtnTwoPage.SetBounds((Width div 2) - 44, (Height div 2) - 12, FBtnTwoPage.Width, FBtnTwoPage.Height);
  FBtnFourPage.SetBounds((Width div 2) - 44, (Height div 2) + 14, FBtnFourPage.Width, FBtnFourPage.Height);
  FPageImage.SetBounds((Width div 2) -14, (Height div 2) - 32, FPageImage.Width, FPageImage.Height);
end;

procedure TGmMultipageImage.BtnClick(Sender: TObject);
begin
  // call the button events when clicked...
  if Assigned(FOnChanging) then FOnChanging(Self);

  if (Sender = FBtnOnePage) and (PagesPerSheet <> gmOnePage) then
  begin
    PagesPerSheet := gmOnePage;
    if Assigned(FOnClickOnePage) then FOnClickOnePage(Self);
  end
  else
  if (Sender = FBtnTwoPage) and (PagesPerSheet <> gmTwoPage) then
  begin
    PagesPerSheet := gmTwoPage;
    if Assigned(FOnClickTwoPage) then FOnClickTwoPage(Self);
  end
  else
  if (Sender = FBtnFourPage) and (PagesPerSheet <> gmFourPage) then
  begin
    PagesPerSheet := gmFourPage;
    if Assigned(FOnClickFourPage) then FOnClickFourPage(Self);
  end;
end;

procedure TGmMultiPageImage.SetPreview(APreview: TGmPreview);
begin
  // assign the preview property to a TGmPreview component...
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  FPreview := APreview;
  if Assigned(FPreview) then
  begin
    FPreview.AddAssociatedComponent(Self);
    PagesPerSheet := FPreview.PagesPerSheet;
  end;
end;

procedure TGmMultipageImage.SetPagesPerSheet(APagesPerSheet: TGmPagesPerSheet);
begin
  FPagesPerSheet := APagesPerSheet;
  if Assigned(FPreview) then FPageImage.FOrientation := FPreview.Orientation;
  FPageImage.PagesPerSheet := APagesPerSheet;
  // select the correct button...
  if FShowButtons then
  begin
    FBtnOnePage.Down  := APagesPerSheet = gmOnePage;
    FBtnTwoPage.Down  := APagesPerSheet = gmTwoPage;
    FBtnFourPage.Down := APagesPerSheet = gmFourPage;
  end;  
  if Assigned(FPreview) then FPreview.PagesPerSheet := APagesPerSheet;
  Invalidate;
end;

procedure TGmMultipageImage.SetShadow(AShadow: TGmShadow);
begin
  // set the shaow for the page image...
  FPageImage.Shadow := AShadow;
  FPageImage.Invalidate;
end;

procedure TGmMultipageImage.SetShowButtons(AValue: Boolean);
begin
  // show or hide the buttons...
  if FShowButtons <> AValue then
  begin
    if AValue = True then
    begin
      FPageImage.Left := 40;
      FBtnOnePage := TSpeedButton.Create(Self);
      with FBtnOnePage do
      begin
        Top := 4;
        Left := 8;
        Glyph.LoadFromResourceName(HInstance, 'ONE');
        GroupIndex := 1;
        Down := True;
        OnClick := BtnClick;
      end;
      FBtnTwoPage := TSpeedButton.Create(Self);
      with FBtnTwoPage do
      begin
        Top := 28;
        Left := 8;
        Glyph.LoadFromResourceName(HInstance, 'TWO');
        GroupIndex := 1;
        OnClick := BtnClick;
      end;
      FBtnFourPage := TSpeedButton.Create(Self);
      with FBtnFourPage do
      begin
        Top := 52;
        Left := 8;
        Glyph.LoadFromResourceName(HInstance, 'FOUR');
        GroupIndex := 1;
        OnClick := BtnClick;
      end;
      FBtnOnePage.Parent := Self;
      FBtnTwoPage.Parent := Self;
      FBtnFourPage.Parent := Self;
    end
    else
    begin
      FPageImage.Left := 4;
      FBtnOnePage.Free;
      FBtnTwoPage.Free;
      FBtnFourPage.Free;
      FBtnOnePage := nil;
      FBtnTwoPage := nil;
      FBtnFourPage := nil;
    end;
    FShowButtons := AValue;
  end;
end;

procedure TGmMultipageImage.SetShowHeaderFooter(AValue: Boolean);
begin
  // show or hide the header/footer...
  FShowHeaderFooter := AValue;
  FPageImage.FShowHeaderFooter := AValue;
  FPageImage.Repaint;
end;

function TGmMultipageImage.GetShadow: TGmShadow;
begin
  // return the TGmShadow object...
  Result := FPageImage.Shadow;
end;

procedure TGmMultipageImage.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

end.
