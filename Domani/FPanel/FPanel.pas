unit FPanel;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Windows, Graphics, Themes,
  Forms;

type
  tFormPanel = class(TCustomPanel)
  private

    FActive: Boolean;
    FAlignment: TAlignment;
    FGlyph: TBitmap;
    FIconized : Boolean;
    FIconWidth  : Integer;
    FIconHeight : Integer;
    FStretch : boolean;
    FDragging: Boolean;
    FLastPos: TPoint;

    procedure SetActive(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetAlignment(Value: TAlignment);
    procedure SetIconized(Value : Boolean);
    procedure GlyphChanged(Sender: TObject);
    procedure SetIconWidth(const Value: Integer);
    procedure SetIconHeight(const Value: Integer);
    procedure SetStretch(const Value: Boolean);

  protected
    procedure Paint; override;
    procedure SetParentBackground(Value: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Click; override;
    procedure DblClick; override;
    procedure Exit;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Active: Boolean read FActive write SetActive default False;
    property Align;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property BevelInner;
    property BevelOuter default bvLowered;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property DragCursor;
    property DragMode;
    property Color default clBtnFace;
    property Ctl3D;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Iconized : Boolean read FIconized write SetIconized;
    property IconWidth  : Integer read FIconWidth write SetIconWidth;
    property IconHeight : Integer read FIconHeight write SetIconHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Stretch : Boolean read FStretch write SetStretch;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Domani', [tFormPanel]);
end;

{ tFormPanel }


{ tFormPanel }

procedure tFormPanel.Click;
begin
  if not Iconized then
     begin
       Active := True; 
       BringToFront;
       Invalidate;
     end;
end;

constructor tFormPanel.Create(AOwner: TComponent);
begin
  inherited;

  Width        := 150;
  Height       := 150;
  FIconHeight  := 50;
  FIconWidth   := 50;
  FAlignment := taCenter;
  FActive := False;
  BevelOuter := bvLowered;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChanged;
  FStretch := True;

end;

procedure tFormPanel.DblClick;
begin
  inherited;
  Iconized := not Iconized;
end;

procedure tFormPanel.Exit;
begin
  inherited;
  Active := false;
  Invalidate;
end;

procedure tFormPanel.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure tFormPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if (not Iconized) and (Button = mbLeft) and ((Width - X) < 10) and ((Height - Y) < 10) then
  begin
    FDragging := TRue;
    FLastPos := Point(X, Y);
    MouseCapture := True;
    Screen.cursor := crSizeNWSE;
  end
  else
    inherited MouseDown(Button, Shift, X, Y);

end;

procedure tFormPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  if FDragging then
  begin
    R := BoundsRect;
    SetBounds(R.Left, R.Top,
      R.Right - R.Left + X - FLastPos.X,
      R.Bottom - R.Top + Y - FLastPos.Y);
    FLastPos := Point(X, Y);
  end
  else
  begin
    inherited MouseMove(Shift, X, Y);
    if ((Width - X) < 10) and ((Height - Y) < 10) then
      Cursor := crSizeNWSE
    else
      Cursor := crDefault;
  end;
end;

procedure tFormPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FDragging then
  begin
    FDragging := False;
    MouseCapture := False;
    Screen.Cursor := crDefault;
  end
  else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure tFormPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);

var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin

  if FIconized then
     begin

       try
        	with inherited Canvas do
            begin
              Brush.Color := Color;
              FillRect(Rect);

              Rect := GetClientRect;

              if Stretch then
                 StretchDraw(Rect, Glyph)
              else
                 Draw(Rect.Top,Rect.Left, Glyph);

            end;

       finally

       end;


     end
  else
     begin

       Rect := GetClientRect;

       if BevelOuter <> bvNone then
          begin
            AdjustColors(BevelOuter);
            Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
          end;

       Frame3D(Canvas, Rect, Color, Color, BorderWidth);
       if BevelInner <> bvNone then
          begin
            AdjustColors(BevelInner);
            Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
          end;

       with Canvas do
          begin

            if not ThemeServices.ThemesEnabled or not ParentBackground then
               begin
                 Brush.Color := Color;
                 FillRect(Rect);
               end;

            Brush.Style := bsClear;
            Font := Self.Font;
            FontHeight := TextHeight('W');
            with Rect do
              begin
                //Top := ((Bottom + Top) - FontHeight) div 2;
                //Top    := Top;
                Bottom := Top + FontHeight;
              end;

            Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[FAlignment];
            Flags := DrawTextBiDiModeFlags(Flags);

            if Active then
               Brush.Color := clActiveCaption
            else
               Brush.Color := clInactiveCaption;

            Font.Color  := clWhite;
            Font.Style  := [fsBold];

            Canvas.FillRect(Rect);

            DrawText(Handle, PChar(Caption), -1, Rect, Flags);
          end;
     end;

end;

procedure tFormPanel.SetActive(Value: Boolean);
begin
  FActive := Value;
  Invalidate;
end;

procedure tFormPanel.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  Invalidate;
end;

procedure tFormPanel.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

procedure tFormPanel.SetIconHeight(const Value: Integer);
begin
  FIconHeight := Value;
  Invalidate;
end;

procedure tFormPanel.SetIconized(Value: Boolean);
begin
  Align     := alNone;
  FIconized := Value;
  Invalidate;
end;

procedure tFormPanel.SetIconWidth(const Value: Integer);
begin
  FIconWidth := Value;
  Invalidate;
end;

procedure tFormPanel.SetParentBackground(Value: Boolean);
begin
  inherited;

end;

procedure tFormPanel.SetStretch(const Value: Boolean);
begin
  FStretch := Value;
  Invalidate;
end;

end.
