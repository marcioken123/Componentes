{***********************************************************
                R&A Library
       Copyright (C) 1996-99 R&A
       Portion copyright (c) 1995,97 Borland International

       components  : TRACaptionButton,
                     TRAColorButton,
                     TRANoFrameButton,
                     TRAhtButton
       description : Buttons

       programer   : white, black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RAButtons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, CommCtrl, StdCtrls, Menus, Buttons, RAHook;

type

 { VCL Buttons unit don't interface TButtonGlyph class,
   so we do it for other programers (Delphi 3 version) }

  TButtonGlyph = class
  private
    FGlyphList: TImageList;
    FIndexs: array[TButtonState] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TNumGlyphs;
    FOnChange: TNotifyEvent;
    FColor : TColor;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure SetColor(Value : TColor);
    procedure Invalidate;
    function CreateButtonGlyph(State: TButtonState): Integer;
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
      State: TButtonState; Transparent: Boolean);
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TButtonState); virtual;
    procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
      const Offset: TPoint; const Caption: string; Layout: TButtonLayout;
      Margin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect);
  protected
    FOriginal: TBitmap;
    procedure CalcTextRect(Canvas: TCanvas; var TextRect: TRect;
      Caption: string); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    { return the text rectangle }
    function Draw(Canvas: TCanvas; const Client: TRect; const Offset: TPoint;
      const Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
      State: TButtonState; Transparent: Boolean): TRect;
    { DrawExternal draws any glyph (not glyph property) -
      if you don't needed to save previous glyph set IgnoreOld to true -
      this increase performance }
    function DrawExternal(AGlyph : TBitmap; ANumGlyphs : TNumGlyphs; AColor : TColor; IgnoreOld : boolean;
      Canvas: TCanvas; const Client: TRect; const Offset: TPoint; const Caption: string;
      Layout: TButtonLayout; Margin, Spacing: Integer; State: TButtonState; Transparent: Boolean): TRect;
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Color : TColor read FColor write SetColor;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TRAhtButtonGlyph }

  TRAhtButtonGlyph = class(TButtonGlyph)
  private
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TButtonState); override;
  protected
    procedure CalcTextRect(Canvas: TCanvas; var TextRect: TRect;
      Caption: string); override;
  end;

  { TRACaptionButton }

  TRACaptionButton = class(TComponent)
  private
    FGlyph : TButtonGlyph;
    FCaption : string;
    FLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FRect : TRect;
    FMouseLButtonDown : boolean;
    FPress : boolean;
    FOnClick : TNotifyEvent;
    FBPos: integer;
    FWidth : integer;
    WHook : TWHook;
    FActive : boolean;
    FFont : TFont;
    FVisible : boolean;

    procedure HookWndProc(var Message: TMessage);
    procedure Draw;
    function MouseOnButton(X, Y : integer) : boolean;
    procedure Resize;
    procedure GlyphChanged(Sender: TObject);

    function GetHeight: integer;
    function GetWidth: integer;
    function GetLeft : integer;

    procedure SetCaption(Value : string);
    function IsCaptionStored : boolean;
    function  GetGlyph : TBitmap;
    procedure SetGlyph(Value : TBitmap);
    function  GetNumGlyphs : TNumGlyphs;
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure SetBPos(const Value: integer);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure SetWidth(const Value: integer);
    procedure SetFont(Value : TFont);
    procedure FontChanged(Sender : TObject);
    procedure SetDown(const Value: boolean);
    procedure SetVisible(const Value: boolean);
  protected
    FState: TButtonState;
    function CalcOffset : TPoint;
    procedure Changed; dynamic;
    function BorderStyle : TFormBorderStyle;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Click; dynamic;
    procedure Update;
  published
    property Position : integer read FBPos write SetBPos;
    property Spacing : Integer read FSpacing write SetSpacing default 4;
    property Layout : TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin : Integer read FMargin write SetMargin default -1;
    property Caption : string read FCaption write SetCaption stored IsCaptionStored;
    property Width : integer read FWidth write SetWidth default -1;
    property Font : TFont read FFont write SetFont;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property NumGlyphs : TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property Down : boolean read FPress write SetDown default false;
    property Visible : boolean read FVisible write SetVisible default true;
    property OnClick : TNotifyEvent read FOnClick write FOnClick;
  end;


  { TRAColorButton }
  TPaintButtonEvent = procedure (Sender : TObject; IsDown, IsDefault : boolean; State : TButtonState) of object;

  TRAColorButton = class(TBitBtn)
  private
    FCanvas : TCanvas;
    FGlyphDrawer : TButtonGlyph;
    FOnPaint: TPaintButtonEvent;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    IsFocused: Boolean;
    procedure SetButtonStyle(ADefault: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultDrawing(const IsDown, IsDefault : boolean; const State : TButtonState);
    property Canvas : TCanvas read FCanvas;
  published
    property Color;
    property ParentColor;
    property OnPaint : TPaintButtonEvent read FOnPaint write FOnPaint;
  end;

  { TRANoFrameButton }

  TRANoFrameButton = class(TSpeedButton)
  private
    FGlyphDrawer : TButtonGlyph;
    FNoBorder : boolean;
    FOnPaint : TPaintButtonEvent;
    procedure SetNoBorder(Value : boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultDrawing(const IsDown : boolean; const State : TButtonState);
    property Canvas;
  published
    property Color;
    property ParentColor;
    property NoBorder : boolean read FNoBorder write SetNoBorder;
    property OnPaint : TPaintButtonEvent read FOnPaint write FOnPaint;
  end;

  { TRAhtButton }

  TRAhtButton = class(TRAColorButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses RAUtils, RADsgnIntf;


{*********************************************************************
 *************************  VCL Buttons unit  ************************
 *********************************************************************}
type

  TGlyphList = class(TImageList)
  private
    Used: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    {$IFDEF RA_D2}
    function Add(Image, Mask: TBitmap): Integer;
    {$ENDIF RA_D2}
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  TGlyphCache = class
  private
    GlyphLists: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight: Integer): TGlyphList;
    procedure ReturnList(List: TGlyphList);
    function Empty: Boolean;
  end;

 { TGlyphList }

constructor TGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;

destructor TGlyphList.Destroy;
begin
  Used.Free;
  inherited Destroy;
end;

function TGlyphList.AllocateIndex: Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

{$IFDEF RA_D2}
function TGlyphList.Add(Image, Mask: TBitmap): Integer;
begin
  Result := AllocateIndex;
  Replace(Result, Image, Mask);
  Inc(FCount);
end;
{$ENDIF RA_D2}

function TGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TGlyphList.Delete(Index: Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ TGlyphCache }

constructor TGlyphCache.Create;
begin
  inherited Create;
  GlyphLists := TList.Create;
end;

destructor TGlyphCache.Destroy;
begin
  GlyphLists.Free;
  inherited Destroy;
end;

function TGlyphCache.GetList(AWidth, AHeight: Integer): TGlyphList;
var
  I: Integer;
begin
  for I := GlyphLists.Count - 1 downto 0 do
  begin
    Result := GlyphLists[I];
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TGlyphList.CreateSize(AWidth, AHeight);
  GlyphLists.Add(Result);
end;

procedure TGlyphCache.ReturnList(List: TGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then
  begin
    GlyphLists.Remove(List);
    List.Free;
  end;
end;

function TGlyphCache.Empty: Boolean;
begin
  Result := GlyphLists.Count = 0;
end;

var
  GlyphCache: TGlyphCache = nil;
  Pattern: TBitmap = nil;

procedure CreateBrushPattern(FaceColor, HighLightColor : TColor);
var
  X, Y: Integer;
begin
  Pattern := TBitmap.Create;
  Pattern.Width := 8;
  Pattern.Height := 8;
  with Pattern.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := FaceColor{clBtnFace};
    FillRect(Rect(0, 0, Pattern.Width, Pattern.Height));
    for Y := 0 to 7 do
      for X := 0 to 7 do
        if (Y mod 2) = (X mod 2) then  { toggles between even/odd pixles }
          Pixels[X, Y] := HighLightColor{clBtnHighlight};     { on even/odd rows }
  end;
end;


{ TButtonGlyph }

constructor TButtonGlyph.Create;
var
  I: TButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
  if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
end;

destructor TButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
  if Assigned(GlyphCache) and GlyphCache.Empty then
  begin
    GlyphCache.Free;
    GlyphCache := nil;
  end;
  inherited Destroy;
end;

procedure TButtonGlyph.Invalidate;
var
  I: TButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then TGlyphList(FGlyphList).Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  GlyphCache.ReturnList(TGlyphList(FGlyphList));
  FGlyphList := nil;
end;

procedure TButtonGlyph.GlyphChanged(Sender: TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;
    Invalidate;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TButtonGlyph.SetGlyph(Value: TBitmap);
var
  Glyphs: Integer;
begin
  Invalidate;
  FOriginal.Assign(Value);
  if (Value <> nil) and (Value.Height > 0) then
  begin
    FTransparentColor := Value.TransparentColor;
    if Value.Width mod Value.Height = 0 then
    begin
      Glyphs := Value.Width div Value.Height;
      if Glyphs > 4 then Glyphs := 1;
      SetNumGlyphs(Glyphs);
    end;
  end;
end;

procedure TButtonGlyph.SetNumGlyphs(Value: TNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Invalidate;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
  end;
end;

procedure TButtonGlyph.SetColor(Value : TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    GlyphChanged(Glyph);
  end;
end;

{$IFDEF RA_D2}
function TButtonGlyph.CreateButtonGlyph(State: TButtonState): Integer;
const
  ROP_DSPDxax = $00E20746;
var
  TmpImage, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TButtonState;
  DestDC: HDC;
begin
  if (State = bsDown) and (NumGlyphs < 3) then State := bsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    I := State;
    if Ord(I) >= NumGlyphs then I := bsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      bsUp, bsDown:
        begin
          TmpImage.Canvas.BrushCopy(IRect, FOriginal, ORect, FTransparentColor);
          FIndexs[State] := TGlyphList(FGlyphList).Add(TmpImage, nil);
        end;
      bsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor);
        end;
      bsDisabled:
        begin
          MonoBmp := TBitmap.Create;
          try
            if NumGlyphs > 1 then
            with TmpImage.Canvas do
            begin    { Change white & gray to clBtnHighlight and clBtnShadow }
              CopyRect(IRect, FOriginal.Canvas, ORect);
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;
              MonoBmp.Monochrome := True;

              { Convert white to clBtnHighlight }
              FOriginal.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
              Brush.Color := clBtnHighlight;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert gray to clBtnShadow }
              FOriginal.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
              Brush.Color := clBtnShadow;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert transparent color to clBtnFace }
              FOriginal.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
              Brush.Color := clBtnFace;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin
              { Create a disabled version }
              with MonoBmp do
              begin
                Assign(FOriginal);
                Canvas.Brush.Color := clBlack;
                Width := IWidth;
                if Monochrome then
                begin
                  Canvas.Font.Color := clWhite;
                  Monochrome := False;
                  Canvas.Brush.Color := clWhite;
                end;
                Monochrome := True;
              end;
              with TmpImage.Canvas do
              begin
                Brush.Color := clBtnFace;
                FillRect(IRect);
                Brush.Color := clBtnHighlight;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                Brush.Color := clBtnShadow;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
            FIndexs[State] := TGlyphList(FGlyphList).Add(TmpImage, nil);
          finally
            MonoBmp.Free;
          end;
       end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;
{$ENDIF RA_D2}

{$IFDEF RA_D3H}
function TButtonGlyph.CreateButtonGlyph(State: TButtonState): Integer;
const
  ROP_DSPDxax = $00E20746;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TButtonState;
  DestDC: HDC;
begin
  if (State = bsDown) and (NumGlyphs < 3) then State := bsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := Color{clBtnFace};
   {$IFDEF RA_D3H}
    TmpImage.Palette := CopyPalette(FOriginal.Palette);
   {$ENDIF RA_D3H}
    I := State;
    if Ord(I) >= NumGlyphs then I := bsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      bsUp, bsDown,
      bsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
         {$IFDEF RA_D2}
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor);
         {$ELSE}
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, clDefault);
          {$ENDIF RA_D2}
        end;
      bsDisabled:
        begin
          MonoBmp := nil;
          DDB := nil;
          try
            MonoBmp := TBitmap.Create;
            DDB := TBitmap.Create;
            DDB.Assign(FOriginal);
           {$IFDEF RA_D3H}
            DDB.HandleType := bmDDB;
           {$ENDIF RA_D3H}
            if NumGlyphs > 1 then
            with TmpImage.Canvas do
            begin    { Change white & gray to clBtnHighlight and clBtnShadow }
              CopyRect(IRect, DDB.Canvas, ORect);
              MonoBmp.Monochrome := True;
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;

              { Convert white to clBtnHighlight }
              DDB.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnHighlight;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert gray to clBtnShadow }
              DDB.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnShadow;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert transparent color to clBtnFace }
              DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := Color{clBtnFace};
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin
              { Create a disabled version }
              with MonoBmp do
              begin
                Assign(FOriginal);
               {$IFDEF RA_D3H}
                HandleType := bmDDB;
               {$ENDIF RA_D3H}
                Canvas.Brush.Color := clBlack;
                Width := IWidth;
                if Monochrome then
                begin
                  Canvas.Font.Color := clWhite;
                  Monochrome := False;
                  Canvas.Brush.Color := clWhite;
                end;
                Monochrome := True;
              end;
              with TmpImage.Canvas do
              begin
                Brush.Color := Color{clBtnFace};
                FillRect(IRect);
                Brush.Color := clBtnHighlight;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                Brush.Color := clBtnShadow;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
          finally
            DDB.Free;
            MonoBmp.Free;
          end;
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, clDefault);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;
{$ENDIF RA_D3H}

procedure TButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
  State: TButtonState; Transparent: Boolean);
var
  Index: Integer;
begin
  if FOriginal = nil then Exit;
  if (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
  Index := CreateButtonGlyph(State);
  with GlyphPos do
    if Transparent or (State = bsExclusive) then
      ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
        clNone, clNone, ILD_Transparent)
    else
      ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
        ColorToRGB(Color{clBtnFace}), clNone, ILD_Normal);
end;

procedure TButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonState);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    if State = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, 0);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, 0);
    end else
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayout; Margin,
  Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect);
var
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
begin
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom -
    Client.Top);

  if FOriginal <> nil then
    GlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height) else
    GlyphSize := Point(0, 0);

  if Length(Caption) > 0 then
  begin
    CalcTextRect(Canvas, TextBounds, Caption);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0,0);
  end;

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y + 1) div 2;
  end
  else
  begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) div 2;
    TextPos.X := (ClientSize.X - TextSize.X + 1) div 2;
  end;

  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  { adjust Margin and Spacing }
  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X + 1) div 2
      else
        Margin := (ClientSize.Y - TotalSize.Y + 1) div 2;
    end;
  end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;

  { fixup the result variables }
  with GlyphPos do
  begin
    Inc(X, Client.Left + Offset.X);
    Inc(Y, Client.Top + Offset.Y);
  end;
  OffsetRect(TextBounds, TextPos.X + Client.Left + Offset.X,
    TextPos.Y + Client.Top + Offset.X);
end;

function TButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayout;
  Margin, Spacing: Integer; State: TButtonState; Transparent: Boolean): TRect;
var
  GlyphPos: TPoint;
begin
  CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing,
    GlyphPos, Result);
  DrawButtonGlyph(Canvas, GlyphPos, State, Transparent);
  DrawButtonText(Canvas, Caption, Result, State);
end;
{#####################################################################
 #########################  VCL Buttons unit  ########################
 #####################################################################}

function TButtonGlyph.DrawExternal(AGlyph : TBitmap; ANumGlyphs : TNumGlyphs; AColor : TColor; IgnoreOld : boolean;
  Canvas: TCanvas; const Client: TRect; const Offset: TPoint; const Caption: string;
  Layout: TButtonLayout; Margin, Spacing: Integer; State: TButtonState; Transparent: Boolean): TRect;
var
  OldGlyph : TBitmap;
  OldNumGlyphs : TNumGlyphs;
  OldColor : TColor;
begin
  OldGlyph := FOriginal;
  OldNumGlyphs := NumGlyphs;
  OldColor := FColor;
  try
    FOriginal := AGlyph;
    NumGlyphs := ANumGlyphs;
    FColor := AColor;
    GlyphChanged(FOriginal);
    Result := Draw(Canvas, Client, Offset, Caption, Layout, Margin,
       Spacing, State, Transparent); 
  finally
    FOriginal := OldGlyph;
    NumGlyphs := OldNumGlyphs;
    FColor := OldColor;
    if not IgnoreOld then
      GlyphChanged(FOriginal);
  end;
end;

procedure TButtonGlyph.CalcTextRect(Canvas: TCanvas; var TextRect: TRect;
  Caption: string);
begin
  TextRect := Rect(0, 0, TextRect.Right - TextRect.Left, 0);
  DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TextRect, DT_CALCRECT);
end;

{ TRAhtButtonGlyph }

procedure TRAhtButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonState);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    if State = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      ItemHtDraw(Canvas, TextBounds, [odSelected], Caption, False);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      ItemHtDraw(Canvas, TextBounds, [odSelected], Caption, False);
    end else
      ItemHtDraw(Canvas, TextBounds, [], Caption, False);
  end;
end;

procedure TRAHtButtonGlyph.CalcTextRect(Canvas: TCanvas; var TextRect: TRect;
  Caption: string);
begin
  TextRect := Rect(0, 0, ItemHtWidth(Canvas, TextRect, [], Caption, False),
    Canvas.TextHeight(Caption));
end;


{****************** TRACaptionButton ******************}

constructor TRACaptionButton.Create(AOwner : TComponent);

  function FindButtonPos : integer;
  var
    i : integer;
    B : TComponent;
  begin
    Result := 4;
    for i := 0 to Owner.ComponentCount - 1 do
    begin
      B := Owner.Components[i];
      if B is TRACaptionButton then
        Result := Max(Result, (B as TRACaptionButton).FBPos + 1);
    end;
  end;

begin
  if not (Owner is TForm) then Exception.Create('RACaptionButton owner must be a TForm');
  inherited Create(AOwner);

  FGlyph := TButtonGlyph.Create;
  TButtonGlyph(FGlyph).OnChange := GlyphChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FBPos := FindButtonPos;
  FMouseLButtonDown := false;
  FPress := false;
  FWidth := -1;
  FMargin := -1;
  FVisible := true;
  WHook := TWHook.Create((Owner as TForm).Handle, HookWndProc);
  Resize;
end;

destructor TRACaptionButton.Destroy;
begin
  WHook.Free;
  if Owner <> nil then
    RedrawWindow((Owner as TForm).Handle, PRect(0), 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
  TButtonGlyph(FGlyph).Free;
  FFont.Free;
  inherited Destroy;
end;

function TRACaptionButton.BorderStyle : TFormBorderStyle;
begin
  if csDesigning in ComponentState then
    Result := bsSizeable else
    Result := (Owner as TForm).BorderStyle;
end;

function TRACaptionButton.GetHeight: integer;
begin
  if BorderStyle in [bsSizeToolWin, bsToolWindow] then
    Result := GetSystemMetrics(SM_CYSMSIZE)
  else
    Result := GetSystemMetrics(SM_CYSIZE);
end;

function TRACaptionButton.GetWidth: integer;
begin
  if FWidth <> -1 then
    Result := FWidth
  else
    if BorderStyle in [bsSizeToolWin, bsToolWindow] then
      Result := GetSystemMetrics(SM_CXSMSIZE)
    else
      Result := GetSystemMetrics(SM_CXSIZE);
end;

function TRACaptionButton.GetLeft : integer;
var
  F : integer;

  function FirstButtonPos : integer;
  var
    i : integer;
    B : TComponent;
  begin
    Result := FBPos;
    for i := 0 to Owner.ComponentCount - 1 do
    begin
      B := Owner.Components[i];
      if B is TRACaptionButton then
        Result := Min(Result, (B as TRACaptionButton).FBPos);
    end;
  end;

  function RightButtonWidth : integer;
  var
    i : integer;
    B : TComponent;
  begin
    Result := 0;
    for i := 0 to Owner.ComponentCount - 1 do
    begin
      B := Owner.Components[i];
      if (B is TRACaptionButton) and
         ((B as TRACaptionButton).FBPos <= FBPos) then
        inc(Result, (B as TRACaptionButton).GetWidth);
    end;
  end;

begin
  if BorderStyle in [bsSizeToolWin, bsToolWindow] then
    F := GetSystemMetrics(SM_CXSMSIZE)
  else
    F := GetSystemMetrics(SM_CXSIZE);
  Result := (Owner as TForm).Width - CalcOffset.X * 2 - F * FirstButtonPos;
  Result := Result - RightButtonWidth;
// Result := 100;
end;

procedure TRACaptionButton.Resize;
begin
  FRect := Bounds(GetLeft, 0, GetWidth, GetHeight);
  RedrawWindow((Owner as TForm).Handle, PRect(0), 0, RDW_FRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE);
end;

function TRACaptionButton.CalcOffset : TPoint;
begin
  case BorderStyle of
    bsSingle : begin
     { Result.X := GetSystemMetrics(SM_CXBORDER) + 1;
      Result.Y := GetSystemMetrics(SM_CYBORDER) + 1; }
      Result.X := GetSystemMetrics(SM_CXDLGFRAME);
      Result.Y := GetSystemMetrics(SM_CYDLGFRAME);
    end;
    bsDialog : begin
      Result.X := GetSystemMetrics(SM_CXDLGFRAME) -1{?};
      Result.Y := GetSystemMetrics(SM_CYDLGFRAME);
    end;
    bsSizeable : begin
      Result.X := GetSystemMetrics(SM_CXFRAME);
      Result.Y := GetSystemMetrics(SM_CYFRAME);
    end;
    bsNone : begin
      Result.X := 0;
      Result.Y := 0;
    end;
    bsToolWindow : begin
      Result.X := GetSystemMetrics(SM_CXDLGFRAME);
      Result.Y := GetSystemMetrics(SM_CYDLGFRAME);
    end;
    bsSizeToolWin : begin
      Result.X := GetSystemMetrics(SM_CXFRAME);
      Result.Y := GetSystemMetrics(SM_CYFRAME);
    end;
  end;
end;

procedure TRACaptionButton.Draw;
var
  DC     : HDC;
  R      : TRect;
  Canvas : TCanvas;
  Offset : TPoint;
const
  CaptionColor : array[boolean] of TColor = (clInactiveCaption, clActiveCaption);
begin
  if not FVisible then exit;
  Offset := CalcOffset;
  DC := GetWindowDC((Owner as TForm).Handle);
  Canvas := TCanvas.Create;
  Canvas.Font := FFont;
  try
    SetWindowOrgEx(DC, -Offset.X, -Offset.Y, nil);
    R := FRect;
    Canvas.Handle := DC;
    Canvas.Brush.Color := CaptionColor[FActive];
    //Canvas.FillRect(R); { commented for Windows98 gradient caption compatibility }
    inc(R.Left, 2);
    inc(R.Top, 2);
    dec(R.Bottom, 2);
    if FPress then
      DrawFrameControl(DC, R, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED)
    else
      DrawFrameControl(DC, R, DFC_BUTTON, DFCS_BUTTONPUSH);

    R := Rect(R.Left +1, R.Top +1, R.Right -2, R.Bottom -2);
    if FPress then OffsetRect(R, 1, 1);

    if FPress then
      TButtonGlyph(FGlyph).Draw(Canvas, R, Point(0, 0),
        FCaption, FLayout, FMargin, FSpacing, bsDown, true)
    else
      TButtonGlyph(FGlyph).Draw(Canvas, R, Point(0, 0),
        FCaption, FLayout, FMargin, FSpacing, bsUp, true);
  finally
    Canvas.Handle := 0;
    Canvas.Free;
    ReleaseDC((Owner as TForm).Handle, DC);
  end;
end;

procedure TRACaptionButton.HookWndProc(var Message: TMessage);
var
  P        : TPoint;
  OldPress : boolean;
begin
  if Owner = nil then exit;
  case Message.Msg of
    WM_NCACTIVATE :
      begin
        FActive := boolean(Message.wParam);
        WHook.CallOldProc(Message);
        Draw;
      end;
    WM_SETTEXT, WM_NCPAINT :
      begin
        WHook.CallOldProc(Message);
        Draw;
      end;
    WM_SIZE :
      begin
        WHook.CallOldProc(Message);
        Resize;
      end;
    WM_NCLBUTTONDOWN :
      if FVisible and
         MouseOnButton(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor) then
      begin
        SetCapture((Owner as TForm).Handle);
        FMouseLButtonDown := true;
        FPress := true;
        Draw;
      end else WHook.CallOldProc(Message);
    WM_NCLBUTTONDBLCLK :
      if FVisible and
         MouseOnButton(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor) then
      begin
      { FPress := true;
        Draw;
        FPress := false;
        Draw;}
      end else WHook.CallOldProc(Message);
    WM_LBUTTONUP :
      if FVisible and FMouseLButtonDown then
      begin
        ReleaseCapture;
        FMouseLButtonDown := false;
        FPress := false;
        Draw;
        P := (Owner as TForm).ClientToScreen(Point(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor));
        if MouseOnButton(P.X, P.Y) then Click;
      end else WHook.CallOldProc(Message);
    WM_MOUSEMOVE :
      if FMouseLButtonDown then
      begin
        P := (Owner as TForm).ClientToScreen(Point(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor));
        OldPress := FPress;
        FPress := MouseOnButton(P.X, P.Y);
        if OldPress <> FPress then Draw;
      end else WHook.CallOldProc(Message);
    WM_NCHITTEST :
      if FVisible and
         MouseOnButton(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor) then
        Message.Result := HTBORDER
      else WHook.CallOldProc(Message);
    WM_NCRBUTTONDOWN :
     { if FVisible and
         MouseOnButton(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor) then
        WHook.CallOldProc(Message)
      else} WHook.CallOldProc(Message);
    WM_SETTINGCHANGE :
      begin
        WHook.CallOldProc(Message);
        Changed;
      end;
    else WHook.CallOldProc(Message);
  end;
end;

procedure TRACaptionButton.Changed;
var
  i : integer;
  B : TComponent;
begin
  for i := 0 to Owner.ComponentCount - 1 do
  begin
    B := Owner.Components[i];
    if (B is TRACaptionButton) then
    begin
      (B as TRACaptionButton).Resize;
      (B as TRACaptionButton).Draw;
    end;
  end;
end;

function TRACaptionButton.MouseOnButton(X, Y : integer) : boolean;
begin
  with (Owner as TForm) do
    Result := PtInRect(FRect, Point(X - Left - CalcOffset.X, Y - Top - CalcOffset.Y));
end;

procedure TRACaptionButton.Click;
begin
  if csDesigning in ComponentState then
    DesignerSelectComponent(Self);
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TRACaptionButton.GlyphChanged(Sender: TObject);
begin
  Changed;
end;

procedure TRACaptionButton.SetCaption(Value : string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

function TRACaptionButton.IsCaptionStored : boolean;
begin
  Result := FCaption <> '';
end;

procedure TRACaptionButton.SetFont(Value : TFont);
begin
  Font.Assign(Value);
  Changed;
end;

procedure TRACaptionButton.FontChanged(Sender : TObject);
begin
  Changed;
end;

function TRACaptionButton.GetGlyph: TBitmap;
begin
  Result := TButtonGlyph(FGlyph).Glyph;
end;

procedure TRACaptionButton.SetGlyph(Value: TBitmap);
begin
  TButtonGlyph(FGlyph).Glyph := Value;
  Changed;
end;

function TRACaptionButton.GetNumGlyphs: TNumGlyphs;
begin
  Result := TButtonGlyph(FGlyph).NumGlyphs;
end;

procedure TRACaptionButton.SetNumGlyphs(Value: TNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> TButtonGlyph(FGlyph).NumGlyphs then
  begin
    TButtonGlyph(FGlyph).NumGlyphs := Value;
    Changed;
  end;
end;

procedure TRACaptionButton.SetBPos(const Value: integer);
begin
  FBPos := Value;
  Changed;
end;

procedure TRACaptionButton.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TRACaptionButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Changed;
  end;
end;

procedure TRACaptionButton.SetSpacing(Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

procedure TRACaptionButton.SetWidth(const Value: integer);
begin
  FWidth := Value;
  Changed;
end;

procedure TRACaptionButton.Update;
begin
  Draw;
end;

procedure TRACaptionButton.SetDown(const Value: boolean);
begin
  FPress := Value;
  Changed;
end;

procedure TRACaptionButton.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  Changed;
end;

{****************** TRAColorButton ******************}

constructor TRAColorButton.Create(AOwner: TComponent);
begin
  FGlyphDrawer := TButtonGlyph.Create;
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
end;

destructor TRAColorButton.Destroy;
begin
  inherited Destroy;
  FGlyphDrawer.Free;
  FCanvas.Free;
end;

procedure TRAColorButton.SetButtonStyle(ADefault: Boolean);
begin
  if ADefault <> IsFocused then
    IsFocused := ADefault;
  inherited SetButtonStyle(ADefault);
end;

procedure TRAColorButton.CNDrawItem(var Message: TWMDrawItem);
var
  DrawItemStruct: TDrawItemStruct;
  IsDown, IsDefault: Boolean;
  State: TButtonState;
begin
  DrawItemStruct := Message.DrawItemStruct^;
  FCanvas.Handle := DrawItemStruct.hDC;
  with DrawItemStruct do
  begin
    IsDown := itemState and ODS_SELECTED <> 0;
    IsDefault := itemState and ODS_FOCUS <> 0;

    if not Enabled then State := bsDisabled
    else if IsDown then State := bsDown
    else State := bsUp;
  end;

  if Assigned(FOnPaint) then
    FOnPaint(Self, IsDown, IsDefault, State)
  else
    DefaultDrawing(IsDown, IsDefault, State);

  FCanvas.Handle := 0;
end;

procedure TRAColorButton.DefaultDrawing(const IsDown, IsDefault : boolean; const State : TButtonState);
var
  R: TRect;
  Flags: Longint;
begin
  if Canvas.Handle = 0 then exit;

  R := ClientRect;
  Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  if IsDown then Flags := Flags or DFCS_PUSHED;
  if State = bsDisabled then
    Flags := Flags or DFCS_INACTIVE;

  { DrawFrameControl doesn't allow for drawing a button as the
      default button, so it must be done here. }
  if IsFocused or IsDefault then
  begin
    FCanvas.Pen.Color := clWindowFrame;
    FCanvas.Pen.Width := 1;
    FCanvas.Brush.Style := bsClear;
    FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

    { DrawFrameControl must draw within this border }
    InflateRect(R, -1, -1);
  end;

  { DrawFrameControl does not draw a pressed button correctly }
  if IsDown then
  begin
    FCanvas.Pen.Color := clBtnShadow;
    FCanvas.Pen.Width := 1;
    FCanvas.Brush.Color := Color{clBtnFace};
    FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    InflateRect(R, -1, -1);
  end
  else
  begin
    DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, Flags);
    FCanvas.Pen.Style := psSolid;
    FCanvas.Pen.Color := Color{clBtnShadow};
    FCanvas.Pen.Width := 1;
    FCanvas.Brush.Color := Color;
    FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
  end;

  if IsFocused then
  begin
    R := ClientRect;
    InflateRect(R, -1, -1);
  end;

  FCanvas.Font := Self.Font;
  if IsDown then
    OffsetRect(R, 1, 1);

  FGlyphDrawer.DrawExternal(Glyph, NumGlyphs, Color, true, FCanvas, R, Point(0,0), Caption, Layout, Margin,
    Spacing, State, false{true}); 

  if IsFocused and IsDefault then
  begin
    R := ClientRect;
    InflateRect(R, -4, -4);
    FCanvas.Pen.Color := clWindowFrame;
    FCanvas.Brush.Color := Color{clBtnFace};
    DrawFocusRect(FCanvas.Handle, R);
  end;

end;
{################## TRAColorButton ##################}



{***************** TRANoFrameButton *****************}

constructor TRANoFrameButton.Create(AOwner: TComponent);
begin
  FGlyphDrawer := TButtonGlyph.Create;
  inherited Create(AOwner);
  FNoBorder := true;
end;

destructor TRANoFrameButton.Destroy;
begin
  inherited Destroy;
  FGlyphDrawer.Free;
end;

procedure TRANoFrameButton.Paint;
begin
  if not Enabled then
  begin
    FState := bsDisabled;
   // FDragging := False;
  end
  else if FState = bsDisabled then
    if Down and (GroupIndex <> 0) then
      FState := bsExclusive
    else
      FState := bsUp;
  if Assigned(FOnPaint) then
    FOnPaint(Self, Down, false, FState)
  else
    DefaultDrawing(Down, FState);
end;

procedure TRANoFrameButton.DefaultDrawing(const IsDown : boolean; const State : TButtonState);
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  PaintRect: TRect;
  Offset: TPoint;
begin
  if {$IFNDEF RA_D2} Flat and {$ENDIF} not NoBorder then
    inherited Paint
  else
  begin
    Canvas.Font := Self.Font;
    PaintRect := Rect(0, 0, Width, Height);
    if not NoBorder then
    begin
     {$IFDEF RA_D4H}
      DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]],
        FillStyles[Transparent] or BF_RECT);
     {$ELSE}
      DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]],
        FillStyles[true{Transparent}] or BF_RECT);
     {$ENDIF RA_D4H}
      InflateRect(PaintRect, -1, -1);
    end;
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := Color;
    Canvas.FillRect(PaintRect);
    if NoBorder and (csDesigning in ComponentState) then
      DrawDesignFrame(Canvas, PaintRect);
    InflateRect(PaintRect, -1, -1);


    if FState in [bsDown, bsExclusive] then
    begin
      if (FState = bsExclusive) then
      begin
        if Pattern = nil then CreateBrushPattern(clBtnFace, clBtnHighlight);
        Canvas.Brush.Bitmap := Pattern;
        Canvas.FillRect(PaintRect);
      end;
      Offset.X := 1;
      Offset.Y := 1;
    end
    else
    begin
      Offset.X := 0;
      Offset.Y := 0;
    end;
    FGlyphDrawer.DrawExternal(Glyph, NumGlyphs, Color, true, Canvas, PaintRect, Offset, Caption, Layout, Margin,
      Spacing, FState, false{true});
  end;
end;

procedure TRANoFrameButton.SetNoBorder(Value : boolean);
begin
  if FNoBorder <> Value then
  begin
    FNoBorder := Value;
    Refresh;
  end;
end;


constructor TRAhtButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyphDrawer.Free;
  FGlyphDrawer := TRAhtButtonGlyph.Create;
end;


end.
