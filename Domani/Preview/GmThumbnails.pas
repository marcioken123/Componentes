{******************************************************************************}
{                                                                              }
{                         GmThumbnails.pas v2.61 Pro                           }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmThumbnails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  GmPreview, GmConst, Menus, GmTypes;

{$I GMPS.INC}

type
  TOnThumbMouseDown = procedure (Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; APage: TGmPage) of object;

  TGmThumbnails = class;
  TGmThumbnailList = class;

  TGmThumbNailLayout = (gmThumbHorz, gmThumbVert, gmThumbGrid);

  TGmThumbnail = class(TGmPaperImage)
  private
    FCaption: string;
    FFont: TFont;
    FPageNum: integer;
    FSelected: Boolean;
    FSelectedColor: TColor;
    FShowCaption: Boolean;
    FThumbList: TGmThumbnailList;
    FThumbSize: integer;
    FThumbSpacing: integer;
    // events...
    FOnClick: TThumbClickEvent;
    FOnMouseDown: TThumbMouseDownEvent;
    function ExpandCaption(ACaption: string): string;
    procedure ResizeThumb;
    procedure SetCaption(ACaption: string);
    procedure SetFont(AFont: TFont);
    procedure SetSelected(ASelected: Boolean);
    procedure SetSelectedColor(AColor: TColor);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Caption: string write SetCaption;
    property Font: TFont read FFont write SetFont;
    property Selected: Boolean read FSelected write SetSelected;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor;
    property ShowCaption: Boolean read FShowCaption write FShowCaption;
    property OnThumbClick: TThumbClickEvent read FOnClick write FOnClick;
    property OnThumbMouseDown: TThumbMouseDownEvent read FOnMouseDown write FOnMouseDown;
  end;

  TGmThumbnailList = class
  private
    FCaptions: string;
    FFont: TFont;
    FPreview: TGmPreview;
    FHighlight: Boolean;
    FItemIndex: integer;
    FScrollIntoView: Boolean;
    FSelectedColor: TColor;
    FShadow: TGmShadow;
    FShowCaption: Boolean;
    FThumbList: TList;
    FThumbnails: TGmThumbnails;
    // events...
    FOnThumbMouseDown: TThumbMouseDownEvent;
    function GetCount: integer;
    function GetThumbnail(index: integer): TGmThumbnail;
    procedure SetFont(AFont: TFont);
    procedure SetHighlight(AValue: Boolean);
    procedure SetItemIndex(index: integer);
    procedure SetPageCaptions(ACaption: string);
    procedure SetSelectedColor(AColor: TColor);
    procedure SetShowCaption(AValue: Boolean);
    procedure SetThumbnail(index: integer; AThumbnail: TGmThumbnail);
    procedure ThumbClicked(Sender: TObject; AIndex: integer);
    procedure ThumbMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; APage: TGmPage);
  public
    constructor Create(AThumbnails: TGmThumbnails);
    destructor Destroy; override;
    function AddThumb: TGmThumbnail;
    procedure Clear;
    procedure DeleteThumb(index: integer);
    property Count: integer read GetCount;
    property Font: TFont write SetFont;
    property Highlight: Boolean read FHighlight write SetHighlight default True;
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    property PageCaptions: string write SetPageCaptions;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property ThumbNail[index: integer]: TGmThumbnail read GetThumbnail write SetThumbnail; default;
    // events...
    property OnThumbMouseDown: TThumbMouseDownEvent read FOnThumbMouseDown write FOnThumbMouseDown;
  end;

  TGmThumbnails = class(TGmCustomThumbnails)
  private
    FBorderStyle: TBorderStyle;
    FEnabled: Boolean;
    FFont: TFont;
    FGridWidth: integer;
    FHighlight: Boolean;
    FLayout: TGmThumbNailLayout;
    FPageCaptions: string;
    FPreview: TGmPreview;
    FScrollIntoView: Boolean;
    FSelectedColor: TColor;
    FShadow: TGmShadow;
    FShowCaption: Boolean;
    FThumbnailList: TGmThumbnailList;
    FThumbPopup: TPopupMenu;
    FThumbSize: integer;
    FThumbSpacing: integer;
    // events...
    FOnThumbMouseDown: TThumbMouseDownEvent;
    function GetItemIndex: integer;
    function SyncronizePages: Boolean;
    procedure Redraw;
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetFont(AFont: TFont);
    procedure SetGridWidth(AWidth: integer);
    procedure SetHighlight(AValue: Boolean);
    procedure SetItemIndex(AValue: integer);
    procedure SetLayout(AValue: TGmThumbNailLayout);
    procedure SetPageCaptions(ACaption: string);
    procedure SetPreview(APreview: TGmPreview);
    procedure SetScrollIntoView(AValue: Boolean);
    procedure SetSelectedColor(AColor: TColor);
    procedure SetShowCaption(AValue: Boolean);
    procedure SetThumbPopup(APopupMenu: TPopupMenu);
    procedure SetThumbSize(AValue: integer);
    procedure SetThumbSpacing(AValue: integer);
    //rocedure ThumbClicked(Sender: TObject; AIndex: integer);
    procedure ThumbMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; APage: TGmPage);
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NumPagesChanged(var Message: TMessage); message GM_NUMPAGES_CHANGED;
    procedure PreviewCleared(var Message: TMessage); message GM_PREVIEW_CLEARED;
    procedure PreviewUpdated(var Message: TMessage); message GM_PREVIEW_UPDATED;
    procedure PageChanged(var Message: TMessage); message GM_PAGE_CHANGED;
    procedure PreviewBeginUpdate(var Message: TMessage); message GM_PREVIEW_BEGINUPDATE;
    procedure PreviewEndUpdateUpdate(var Message: TMessage); message GM_PREVIEW_ENDUPDATE;
    procedure SetEnabled(AValue: Boolean); {$IFDEF D4+} override; {$ENDIF}
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ItemIndex: integer read GetItemIndex write SetItemIndex;
    { Public declarations }
  published
    property Align;
    {properties available from Delphi 4...}
    {$IFDEF D4+}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Color default clGray;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property CaptionFont: TFont read FFont write SetFont;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property GridWidth: integer read FGridWidth write SetGridWidth default 4;
    property Highlight: Boolean read FHighlight write SetHighlight default True;
    property Layout: TGmThumbNailLayout read FLayout write SetLayout default gmThumbHorz;
    property PageCaptions: string read FPageCaptions write SetPageCaptions;
    property PopupMenu;
    property Preview: TGmPreview read FPreview write SetPreview;
    property ScrollIntoView: Boolean read FScrollIntoView write SetScrollIntoView default True;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor default clBlue;
    property Shadow: TGmShadow read FShadow write FShadow;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property ShowHint;
    property TabOrder;
    property ThumbPopup: TPopupMenu read FThumbPopup write SetThumbPopup;
    property ThumbSize: integer read FThumbSize write SetThumbSize default 3;
    property ThumbSpacing: integer read FThumbSpacing write SetThumbSpacing default 6;
    property Visible;
    // events...
    property OnThumbMouseDown: TThumbMouseDownEvent read FOnThumbMouseDown write FOnThumbMouseDown;
    { Published declarations }
  end;

implementation

//------------------------------------------------------------------------------

{ TGmThumbnail }

constructor TGmThumbnail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Gutter := 5;
  Cursor := crHandPoint;
  FSelected := False;
  FThumbSize := 4;
end;

destructor TGmThumbnail.Destroy;
begin
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmThumbnail.ExpandCaption(ACaption: string): string;
var
  TokenIndex: integer;
begin
  Result := ACaption;
  while Pos('#', Result) > 0 do
  begin
    TokenIndex := Pos('#', Result);
    Delete(Result, TokenIndex, 1);
    Insert(IntToStr(FPageNum), Result, TokenIndex);
  end;
end;

procedure TGmThumbnail.ResizeThumb;
begin
  if FShowCaption then
    Borders := Rect(FThumbSpacing,
                    FThumbSpacing,
                    FThumbSpacing,
                    (0-FFont.Height)+5)
  else
    Borders := Rect(FThumbSpacing,
                    FThumbSpacing,
                    FThumbSpacing,
                    FThumbSpacing);
  Width  := (Borders.Left + Borders.Right) + (Gutter * 2) + Round(Page.PageWidth.AsMillimeters / 18 * (FThumbSize+1));
  Height := (Borders.Top + Borders.Bottom) + (Gutter * 2) + Round(Page.PageHeight.AsMillimeters / 18 * (FThumbSize+1));
end;

procedure TGmThumbnail.SetCaption(ACaption: string);
begin
  if FCaption <> ACaption then
  begin
    FCaption := ACaption;
    Invalidate;
  end;
end;

procedure TGmThumbnail.SetFont(AFont: TFont);
begin
  FFont := AFont;
  ResizeThumb;
  Invalidate;
end;

procedure TGmThumbnail.SetSelected(ASelected: Boolean);
begin
  if (FSelected <> ASelected) or (ASelected = True) then
  begin
    FSelected := ASelected;
    Invalidate;
  end;
end;

procedure TGmThumbnail.SetSelectedColor(AColor: TColor);
begin
  if FSelectedColor <> AColor then
  begin
    FSelectedColor := AColor;
    if FSelected then Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TGmThumbnail.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, Shift, Page);
  if Button = mbLeft then
    if Assigned(FOnClick) then FOnClick(Self, Page.PageNum);
end;

procedure TGmThumbnail.Paint;
var
  ACaption: string;
begin
  if FThumbList.FThumbnails.Enabled then
    inherited
  else
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.Rectangle(PageRect.Left, PageRect.Top, PageRect.Right, PageRect.Bottom);
  end;
  Canvas.Brush.Style := bsClear;
  if FSelected then
    Canvas.Pen.Color := FSelectedColor
  else
    Canvas.Pen.Color := clBlack;
  Canvas.Rectangle(PageRect.Left, PageRect.Top, PageRect.Right, PageRect.Bottom);
  if FShowCaption then
  begin
    ACaption := ExpandCaption(FCaption);
    Canvas.Font.Assign(FFont);
    Canvas.Font.Color := Canvas.Pen.Color;
    Canvas.TextOut((Width - Canvas.TextWidth(ACaption)) div 2,
                   Height - (Canvas.TextHeight(ACaption)+2),
                   ACaption);
  end;
end;

//------------------------------------------------------------------------------



{ TGmThumbnailList }

constructor TGmThumbnailList.Create(AThumbnails: TGmThumbnails);
begin
  inherited Create;
  FThumbnails := AThumbnails;
  FThumbList := TList.Create;
  FHighlight := True;
end;

destructor TGmThumbnailList.Destroy;
begin
  Clear;
  FThumbList.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmThumbnailList.GetCount: integer;
begin
  Result := FThumbList.Count;
end;

function TGmThumbnailList.GetThumbnail(index: integer): TGmThumbnail;
begin
  Result := TGmThumbnail(FThumbList[index]);
end;

procedure TGmThumbnailList.SetFont(AFont: TFont);
var
  ICount: integer;
begin
  for ICount := 0 to FThumbList.Count-1 do
    ThumbNail[ICount].Font := AFont;
  FFont := AFont;
end;

procedure TGmThumbnailList.SetHighlight(AValue: Boolean);
begin
  if FHighlight <> AValue then
  begin
    FHighlight := AValue;
    SetSelectedColor(FSelectedColor);
  end;
end;

procedure TGmThumbnailList.SetItemIndex(index: integer);
var
  ICount: integer;
begin
  if Index < 1 then Exit;
  for ICount := 0 to FThumbList.Count-1 do
    ThumbNail[ICount].Selected := ICount = index-1;
  if FScrollIntoView then FThumbnails.ScrollInView(ThumbNail[index-1]);
  FPreview.CurrentPage := index;
end;

procedure TGmThumbnailList.SetPageCaptions(ACaption: string);
var
  ICount: integer;
begin
  for ICount := 0 to FThumbList.Count-1 do
    ThumbNail[ICount].Caption := ACaption;
  FCaptions := ACaption;
end;

procedure TGmThumbnailList.SetSelectedColor(AColor: TColor);
var
  ICount: integer;
  NewColor: TColor;
begin
  if FHighlight then NewColor := AColor else NewColor := clBlack;
  for ICount := 0 to FThumbList.Count-1 do
    ThumbNail[ICount].SelectedColor := NewColor;
  FSelectedColor := AColor;
end;

procedure TGmThumbnailList.SetShowCaption(AValue: Boolean);
var
  ICount: integer;
begin
  for ICount := 0 to FThumbList.Count-1 do
    ThumbNail[ICount].ShowCaption := AValue;
  FShowCaption := AValue;
end;

procedure TGmThumbnailList.SetThumbnail(index: integer; AThumbnail: TGmThumbnail);
begin
  FThumbList[index] := AThumbnail;
end;

procedure TGmThumbnailList.ThumbClicked(Sender: TObject; AIndex: integer);
begin
  ItemIndex := AIndex;
end;

procedure TGmThumbnailList.ThumbMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; APage: TGmPage);
begin
  if Assigned(FOnThumbMouseDown) then FOnThumbMouseDown(Sender, Button, Shift, APage);
end;

//------------------------------------------------------------------------------

// *** Public functions ***

function TGmThumbnailList.AddThumb: TGmThumbnail;
begin
  Result := TGmThumbnail.Create(FThumbnails);
  Result.FThumbList := Self;
  Result.Shadow := FShadow;
  Result.OnThumbClick := ThumbClicked;
  Result.OnThumbMouseDown := ThumbMouseDown;
  Result.FShowCaption := FThumbnails.ShowCaption;
  Result.FCaption := FCaptions;
  Result.FFont := FFont;
  Result.FSelectedColor := FSelectedColor;
  Result.FThumbSize := FThumbnails.ThumbSize;
  Result.PopupMenu := FThumbnails.ThumbPopup;
  FThumbList.Add(Result);
end;

procedure TGmThumbnailList.Clear;
var
  ICount: integer;
begin
  for ICount := FThumbList.Count-1 downto 0 do
    DeleteThumb(ICount);
  FThumbList.Clear;
end;

procedure TGmThumbnailList.DeleteThumb(index: integer);
begin
  TGmThumbnail(FThumbList[index]).Free;
  FThumbList.Delete(index);
end;

//------------------------------------------------------------------------------

{ TGmThumbnails }

constructor TGmThumbnails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShadow := TGmShadow.Create;
  FThumbnailList := TGmThumbnailList.Create(Self);
  FFont := TFont.Create;

  // set events...
  FThumbnailList.OnThumbMouseDown := ThumbMouseDown;

  // link objects...
  FThumbnailList.FPreview := FPreview;
  FThumbnailList.FShadow := FShadow;
  FThumbnailList.Font := FFont;

  // properties...
  FEnabled := True;
  Width := 240;
  Height := 115;
  FBorderStyle := bsSingle;
  FGridWidth := 4;
  ScrollIntoView := True;
  SelectedColor := clBlue;
  FShadow.Width := 3;
  FShowCaption := True;
  FThumbSize := 3;
  FThumbSpacing := 6;
  PageCaptions := DEFAULT_PAGE_CAPTION;
  Color := clGray;
  FHighlight := True;
end;

destructor TGmThumbnails.Destroy;
begin
  FFont.Free;
  FThumbnailList.Free;
  FShadow.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmThumbnails.GetItemIndex: integer;
begin
  Result := FThumbnailList.ItemIndex;
end;

function TGmThumbnails.SyncronizePages: Boolean;
begin
  Result := False;
  if FPreview.NumPages = FThumbnailList.Count then Exit;
  while FThumbnailList.Count < FPreview.NumPages do
    FThumbnailList.AddThumb;
  while FThumbnailList.Count > FPreview.NumPages do
    FThumbnailList.DeleteThumb(FThumbnailList.Count-1);
  Result := True;
end;

procedure TGmThumbnails.Redraw;
var
  ICount: integer;
  AStartPoint: TPoint;
  APoint: TPoint;
  AThumb: TGmThumbnail;
begin
  if not Assigned(FPreview) then Exit;
  DisableAutoRange;
  try
    SyncronizePages;
    AStartPoint := Point(0-HorzScrollBar.Position,0-VertScrollBar.Position);
    APoint := AStartPoint;
    for ICount := 0 to FThumbnailList.Count-1 do
    begin
      AThumb := FThumbnailList.Thumbnail[ICount];
      AThumb.Page := FPreview.Pages[ICount+1];
      AThumb.FPageNum := ICount+1;
      AThumb.ResizeThumb;
      AThumb.Left := APoint.x;
      AThumb.Top := APoint.y;
      if not AThumb.HasParent then
        AThumb.Parent := Self;

      //Inc(APoint.x, AThumb.Width);
      case FLayout of
        gmThumbHorz: Inc(APoint.x, AThumb.Width);
        gmThumbVert: Inc(APoint.y, AThumb.Height);
        gmThumbGrid:
        begin
          Inc(APoint.x, AThumb.Width);
          if (ICount+1) mod (FGridWidth) = 0 then
          begin
            APoint.x := AStartPoint.x;
            Inc(APoint.y, AThumb.Height);
          end;
        end;
      end;
    end;
  finally
    EnableAutoRange;
    FThumbnailList.ItemIndex := FPreview.CurrentPage;
  end;
end;

procedure TGmThumbnails.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TGmThumbnails.SetEnabled(AValue: Boolean);
begin
  inherited;
  if FEnabled = AValue then Exit;
  FEnabled := AValue;
  if FEnabled then
  begin
    Redraw;
    Invalidate;
  end;
end;

procedure TGmThumbnails.SetFont(AFont: TFont);
begin
  FFont.Assign(AFont);
  FThumbnailList.Font := FFont;
  Redraw;
end;

procedure TGmThumbnails.SetGridWidth(AWidth: integer);
begin
  if FGridWidth <> AWidth then
  begin
    FGridWidth := AWidth;
    FLayout := gmThumbGrid;
    Redraw;
  end;
end;

procedure TGmThumbnails.SetHighlight(AValue: Boolean);
begin
  if FHighlight <> AValue then
  begin
    FHighlight := AValue;
    FThumbnailList.Highlight := FHighlight;
    Invalidate;
  end;
end;

procedure TGmThumbnails.SetItemIndex(AValue: integer);
begin
  FThumbnailList.ItemIndex := AValue;
end;

procedure TGmThumbnails.SetLayout(AValue: TGmThumbNailLayout);
begin
  if FLayout <> AValue then
  begin
    FLayout := AValue;
    Redraw;
  end;
end;

procedure TGmThumbnails.SetPageCaptions(ACaption: string);
begin
  if FPageCaptions <> ACaption then
  begin
    FPageCaptions := ACaption;
    FThumbnailList.PageCaptions := FPageCaptions;
  end;
end;

procedure TGmThumbnails.SetPreview(APreview: TGmPreview);
begin
  if Assigned(FPreview) then
  begin
    FPreview.RemoveAssociatedComponent(Self);
    FThumbnailList.Clear;
  end;
  FPreview := APreview;
  FThumbnailList.FPreview := APreview;
  if Assigned(FPreview) then
  begin
    FPreview.AddAssociatedComponent(Self);
    Redraw;
  end;
end;

procedure TGmThumbnails.SetScrollIntoView(AValue: Boolean);
begin
  if FScrollIntoView <> AValue then
  begin
    FScrollIntoView := AValue;
    FThumbnailList.FScrollIntoView := FScrollIntoView;
  end;
end;

procedure TGmThumbnails.SetSelectedColor(AColor: TColor);
begin
  if FSelectedColor <> AColor then
  begin
    FSelectedColor := AColor;
    FThumbnailList.SelectedColor := AColor;
    Invalidate;
  end;
end;

procedure TGmThumbnails.SetShowCaption(AValue: Boolean);
begin
  if FShowCaption <> AValue then
  begin
    FShowCaption := AValue;
    FThumbnailList.ShowCaption := FShowCaption;
    Redraw;
  end;
end;

procedure TGmThumbnails.SetThumbPopup(APopupMenu: TPopupMenu);
var
  ICount: integer;
begin
  FThumbPopup := APopupMenu;
  for ICount := 0 to FThumbnailList.Count-1 do
    FThumbnailList[ICount].PopupMenu := FThumbPopup;
end;

procedure TGmThumbnails.SetThumbSize(AValue: integer);
var
  ICount: integer;
begin
  if FThumbSize <> AValue then
  begin
    FThumbSize := AValue;
    for ICount := 0 to FThumbnailList.Count-1 do
      FThumbnailList[ICount].FThumbSize := FThumbSize;
    Redraw;
  end;
end;

procedure TGmThumbnails.SetThumbSpacing(AValue: integer);
var
  ICount: integer;
begin
  if FThumbSpacing <> AValue then
  begin
    FThumbSpacing := AValue;
    for ICount := 0 to FThumbnailList.Count-1 do
      FThumbnailList[ICount].FThumbSpacing := FThumbSpacing;
    Redraw;
  end;
end;

procedure TGmThumbnails.ThumbMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; APage: TGmPage);
begin
  if Assigned(FOnThumbMouseDown) then FOnThumbMouseDown(Self, Button, Shift, APage);
end;

//------------------------------------------------------------------------------

procedure TGmThumbnails.CreateParams(var Params: TCreateParams);
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

procedure TGmThumbnails.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
  begin
    FPreview := nil;
    FThumbnailList.Clear;
  end;
end;

procedure TGmThumbnails.NumPagesChanged(var Message: TMessage);
begin
  Redraw;
end;

procedure TGmThumbnails.PreviewCleared(var Message: TMessage);
begin
  Invalidate;
end;

procedure TGmThumbnails.PreviewUpdated(var Message: TMessage);
begin
  Redraw;
end;

procedure TGmThumbnails.PageChanged(var Message: TMessage);
begin
  Redraw;
end;

procedure TGmThumbnails.PreviewBeginUpdate(var Message: TMessage);
begin
  Enabled := False;
end;

procedure TGmThumbnails.PreviewEndUpdateUpdate(var Message: TMessage);
begin
  Enabled := True;
end;

end.
