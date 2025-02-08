unit LMDGlyphs;
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

LMDGlyphs unit - Unit for complex draw button's Glyph (AH)
----------------------------------------------------------
This unit used in most button like controls to draw Glyph and
caption with html formating, alpha channel etc. With various
format options.

ToDo
----
* VCL.NET support

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Math,  Windows, Messages,  Types,
  Graphics, Controls, Forms, Buttons, CommCtrl, Menus, ImgList, ActnList,
  Themes, LMDThemes,
  LMDClass, LMDUnicode, LMDPNGImage, LMDGraph, LMDGraphUtils, LMDObjectList,
  LMDTypes, LMDProcs, LMDPNGImageList, LMDHTMLUnit
  ,LMDPNGImageFilters{$ifdef LMD_ELUNISCRIBE}, LMDUsp10, LMDUniscribeStrings{$ENDIF};

type TLMDGlyphListMaskUsage = (muUnmasked, muMasked, muGlyphList);

type
  TLMDGlyphList = class(TImageList)
  private
    Used : TBits;
    FCount : Integer;
    function AllocateIndex : Integer;
  public
    constructor CreateSize(AWidth, AHeight : Integer);
    destructor Destroy; override;
    function AddMasked(Image: TBitmap; MaskColor: TColor; aMaskUsage: TLMDGlyphListMaskUsage = muGlyphList) : Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  TLMDGlyphCache = class
  private
    GlyphLists : TLMDObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight : Integer) : TLMDGlyphList;
    procedure ReturnList(List : TLMDGlyphList);
    function Empty : Boolean;
  end;

  TLMDButtonGlyph = class
  protected
    FResizable: Boolean;
    FImageList : TCustomImageList;
    FAlphaImageList: TCustomImageList;
    FImageIndex : Integer;
    FUseImageList : Boolean;
    FIcon : TIcon;
    FUseIcon : Boolean;
    FOriginal : TBitmap;
    FGlyphList : TLMDGlyphList;
    FIndexs : array[TLMDExButtonState] of Integer;
    FTransparentColor : TColor;
    FNumGlyphs : TNumGlyphs;
    FOnChange : TNotifyEvent;
    FStretched : boolean;
    FStrW: integer;
    FStrH: integer;
    {$ifdef LMD_UNICODE}
    {$ifdef LMD_ELUNISCRIBE}
    FUniscribeString: TLMDUniscribeStrings;
    {$endif}
    {$endif}
    FPngGlyph: TLMDPNGObject;
    FUsePng: boolean;
    procedure SetUsePng(const Value: boolean);
    procedure SetPngGlyph(const Value: TLMDPNGObject);
    //procedure ImageListChanged(Sender : TObject);
    procedure SetImageList(NewValue  : TCustomImageList);virtual;
    procedure SetAlphaImageList(NewValue: TCustomImageList);virtual;
    procedure SetImageIndex(NewValue : Integer);
    procedure GlyphChanged(Sender : TObject);
    procedure PngChanged(Sender : TObject);
    procedure IconChanged(Sender : TObject);
    procedure SetGlyph(Value : TBitmap);
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure Repaint;
    function CreateButtonGlyph(State : TLMDExButtonState; aMaskUsage: TLMDGlyphListMaskUsage = muGlyphList) : Integer; virtual;
    procedure DrawButtonGlyph(Canvas : TCanvas; const GlyphPos : TPoint; State :
        TLMDExButtonState; Transparent : Boolean; Color : TColor; AlphaBlended :
        boolean; MaskUsage: TLMDGlyphListMaskUsage = muGlyphList);
    procedure DrawButtonText(Canvas: TCanvas; const Caption: TLMDString;
        TextBounds: TRect; State: TLMDExButtonState; Multiline: boolean;
        Alignment: TAlignment; Active, Transparent: boolean; TextDrawType: TLMDTextDrawType;
        ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
        ShowAccelChar: boolean; IsHTML: boolean;
        HTMLRender: TLMDHTMLRender; ChangeDisabledText: boolean);
    procedure CalcButtonLayout(Canvas : TCanvas; const Client : TRect; const OffsetSize
        : TPoint; const Caption : TLMDString; Layout : TButtonLayout; Margin,
        Spacing : Integer; var GlyphPos : TPoint; var TextBounds : TRect; ShowGlyph,
        ShowText, MultiLine : boolean; ArrowWidth : integer;
        ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
        ShowAccelChar : boolean; IsHTML : boolean; HTMLRender : TLMDHTMLRender; Alignments: TAlignment);
    function GetGlyphSize : TRect;
    procedure SetUseIcon(NewValue : boolean);
  protected
    property ImageList : TCustomImageList read FImageList write SetImageList;
    property AlphaImageList: TCustomImageList read FAlphaImageList write SetAlphaImageList;
    property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
    property UseImageList : Boolean read FUseImageList write FUseImageList;
  public
    constructor Create;
    destructor Destroy; override;
    { return the text rectangle }
    procedure ResetNumGlyphs;
    function Draw(Canvas : TCanvas; const Client : TRect; const Offset : TPoint;
        const Caption : TLMDString; Layout : TButtonLayout; Margin, Spacing :
        Integer; State, GlyphState : TLMDExButtonState; Alignment : TAlignment;
        Transparent : Boolean; Multiline : boolean; Active, ShowGlyph,
        ShowText : boolean; ArrowWidth : integer; TextDrawType : TLMDTextDrawType;
        Color : TColor; ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
        ShowAccelChar : boolean; ImageIsAlphaBlended : boolean; IsHTML: boolean;
        HTMLRender: TLMDHTMLRender; ChangeDisabledText: boolean;
        MaskUsage: TLMDGlyphListMaskUsage = muGlyphList): TRect;
    procedure GetPaintGlyphSize(R : TRect; var Size : TPoint);
    function CalcButtonWidth(Canvas : TCanvas; var MaxHeight : integer; const
        Offset : TPoint; const Caption : TLMDString; Layout : TButtonLayout; Margin,
        Spacing : Integer; ShowGlyph, ShowText, MultiLine : boolean; ArrowWidth :
        integer; ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
        ShowAccelChar : boolean; IsHTML : boolean; HTMLRender : TLMDHTMLRender): Integer;
    property UseIcon: boolean read FUseIcon write SetUseIcon;
    property Icon: TIcon read FIcon;
    property UsePng: boolean read FUsePng write SetUsePng;
    property PngGlyph: TLMDPNGObject read FPngGlyph write SetPngGlyph;
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs default 1;
    property GlyphSize: TRect read GetGlyphSize;
    property Resizable: Boolean read FResizable write FResizable;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

var
  GlyphCache: TLMDGlyphCache = nil;
  Pattern: TBitmap = nil;
  ButtonCount: Integer = 0;

implementation

uses
  LMDSysIn;

constructor TLMDGlyphList.CreateSize(AWidth, AHeight : Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;

destructor TLMDGlyphList.Destroy;
begin
  Used.Free;
  inherited Destroy;
end;

function TLMDGlyphList.AllocateIndex : Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

function TLMDGlyphList.AddMasked(Image : TBitmap; MaskColor : TColor; aMaskUsage: TLMDGlyphListMaskUsage = muGlyphList) : Integer;
const
  Mask: array[Boolean] of Longint = (0, ILC_MASK);
var
  DC : HDC;
  lmask: longint;
begin
  if not HandleAllocated and (not LMDApplication.XPThemesSupported) and not LMDSIWindowsVistaUp then
    begin
      DC := GetDC(0);
      if (GetDeviceCaps(DC, BITSPIXEL) = 32) then
        begin
          lmask := 0;
          case aMaskUsage of
            muUnmasked:  lmask := Mask[false];
            muMasked:    lmask := Mask[true];
            muGlyphList: lmask := Mask[Masked];
          end;
          Handle := ImageList_Create(Width, Height, ILC_COLOR32 or lmask, AllocBy, AllocBy);
        end;
      ReleaseDC(0, DC);
    end;
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TLMDGlyphList.Delete(Index : Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ TElGlyphCache }

constructor TLMDGlyphCache.Create;
begin
  inherited Create;
  GlyphLists := TLMDObjectList.Create;
end;

destructor TLMDGlyphCache.Destroy;
begin
  GlyphLists.Free;
  inherited Destroy;
end;

function TLMDGlyphCache.GetList(AWidth, AHeight : Integer): TLMDGlyphList;
var
  I : Integer;
begin
  for I := GlyphLists.Count - 1 downto 0 do
  begin
    Result := TLMDGlyphList(GlyphLists[I]);
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TLMDGlyphList.CreateSize(AWidth, AHeight);
  GlyphLists.Add(Result);
end;

procedure TLMDGlyphCache.ReturnList(List : TLMDGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then
  begin
    GlyphLists.Remove(List);
    List.Free;
  end;
end;

function TLMDGlyphCache.Empty : Boolean;
begin
  Result := GlyphLists.Count = 0;
end;

{ TElButtonGlyph }

constructor TLMDButtonGlyph.Create;
var
  I : TLMDExButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FResizable := true;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
  if GlyphCache = nil then
    GlyphCache := TLMDGlyphCache.Create;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FUniscribeString := TLMDUniscribeStrings.Create;
  {$endif}
  {$endif}

  FPngGlyph := TLMDPNGObject.Create;
  FPngGlyph.OnChange := PngChanged;

  FImageIndex := -1;
end;

destructor TLMDButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Repaint;
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FreeAndNil(FUniscribeString);
  {$endif}
  {$endif}
  if Assigned(GlyphCache) and GlyphCache.Empty then
  begin
    GlyphCache.Free;
    GlyphCache := nil;
  end;
  FIcon.Free;
  FPngGlyph.Free;
  inherited Destroy;
end;

procedure TLMDButtonGlyph.Repaint;
var
  I : TLMDExButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then
      FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  GlyphCache.ReturnList(FGlyphList);
  FGlyphList := nil;
end;

procedure TLMDButtonGlyph.SetImageIndex(NewValue : Integer);
begin
  if FImageIndex <> NewValue then
  begin
    FImageIndex := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TLMDButtonGlyph.SetImageList(NewValue : TCustomImageList);
begin
  if FImageList <> NewValue then
  begin
    FImageList := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TLMDButtonGlyph.SetAlphaImageList(NewValue : TCustomImageList);
begin
  if FAlphaImageList <> NewValue then
  begin
    FAlphaImageList := NewValue;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TLMDButtonGlyph.IconChanged(Sender : TObject);
begin
  if FIcon.Empty then
    UseIcon := false;
  Repaint;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TLMDButtonGlyph.PngChanged(Sender: TObject);
begin
  if Sender = FPngGlyph then
  begin
    FTransparentColor := FOriginal.TransparentColor;

    ResetNumGlyphs;
    Repaint;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TLMDButtonGlyph.GlyphChanged(Sender : TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;

    ResetNumGlyphs;
    Repaint;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TLMDButtonGlyph.ResetNumGlyphs;
var Value : TBitmap;
    Glyphs: Integer;

begin
  Value := FOriginal;
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
  if (Value = nil) or (Value.Empty) then SetNumGlyphs(1);
end;

procedure TLMDButtonGlyph.SetGlyph(Value : TBitmap);
begin
  Repaint;
  FOriginal.Assign(Value);
  if Value <> nil then
    FTransparentColor := Value.TransparentColor;
end;

procedure TLMDButtonGlyph.SetNumGlyphs(Value : TNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Repaint;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
    FNumGlyphs := Value;
  end;
end;

procedure TLMDButtonGlyph.SetPngGlyph(const Value: TLMDPNGObject);
begin
  Repaint;
  FPngGlyph.Assign(Value);
  if Value <> nil then
    FTransparentColor := Value.TransparentColor;
end;

function TLMDButtonGlyph.CreateButtonGlyph(State : TLMDExButtonState; aMaskUsage: TLMDGlyphListMaskUsage = muGlyphList) : Integer;
var
  TmpImage : TBitmap;
  IWidth, IHeight : Integer;
  IRect, ORect : TRect;
  I : TLMDExButtonState;
begin
  if (State = ebsDown) and (NumGlyphs < 3) then
    State := ebsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width = 0) or (FOriginal.Height = 0) then
    Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then
      GlyphCache := TLMDGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    if FOriginal.PixelFormat <> pfCustom then
      TmpImage.PixelFormat := pf32bit;//FOriginal.PixelFormat; {pf24bit;}
    TmpImage.Palette := CopyPalette(FOriginal.Palette);

    I := State;
    if Ord(I) >= NumGlyphs then I := ebsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      ebsUp, ebsDown,
        ebsArrDown,
        ebsExclusive :
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor, aMaskUsage)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault, aMaskUsage);
        end;
      ebsDisabled :
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          TmpImage.Canvas.Brush.Color := TmpImage.Canvas.Pixels[0, TmpImage.Height - 1];
          if NumGlyphs < 2 then
            LMDSetGrayscaleDisabled(TmpImage);
            //SetDisabled(TmpImage);
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, TmpImage.Canvas.Pixels[0, TmpImage.Height - 1], aMaskUsage);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TLMDButtonGlyph.DrawButtonGlyph(Canvas : TCanvas; const GlyphPos :
    TPoint; State : TLMDExButtonState; Transparent : Boolean; Color : TColor;
    AlphaBlended : boolean; MaskUsage: TLMDGlyphListMaskUsage = muGlyphList);
var
  Index   : Integer;
  TC, OTC : TColor;
  BMP     : TBitmap;
  FStyle  : TBrushStyle;
  IcW,
  IcH     : Integer;
  IconInfo: TIconInfo;
  ABMP    : Windows.TBitmap;

  AlphaIL: boolean;
  BmpAm : TBitmap;
  LPNGFilter: TLMDPNGAlphaBlendFilter;
  const
  ROP_DSPDxax = $00E20746;

begin
  if FUseImageList and (FImageList <> nil) then
    begin
      if ImageIndex <> -1 then
        begin
          AlphaIL := (FAlphaImageList<> nil) and (ImageIndex < FAlphaImageList.Count);
            AlphaBlended := AlphaIL;
          if FStretched or (State = ebsDisabled) then
            begin
              BMP := TBitmap.Create;
              Bmp.PixelFormat := pf24bit;
              if FStretched then
                begin
                  BMP.Width := FImageList.Width;
                  Bmp.Height := FImageList.Height;
                end
              else
                begin
                  BMP.Width := FImageList.Width;
                  Bmp.Height := FImageList.Height;
                end;
              with GlyphPos do
                if Transparent or (State = ebsExclusive) or (Color = clNone) then
                  ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
                    clNone, clNone, ILD_Transparent)
                else
                  ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
                    ColortoRGB(clBtnFace){CLR_DEFAULT}, clNone, ILD_Normal);
              FStyle := Canvas.Brush.Style;
              TC := BMP.Canvas.Pixels[0, BMP.Height - 1];
              OTC := Canvas.Brush.Color;
              Canvas.Brush.Color := TC;

              if FStretched then
                begin
                  Canvas.Brush.Style := bsClear;
                  if AlphaBlended then
                    begin
                      if AlphaIL then
                        begin
                          BmpAm := TBitmap.Create;
                          BmpAm.Width := FAlphaImageList.Width;
                          BmpAm.Height := FAlphaImageList.Height;
                          BmpAm.PixelFormat := pf32bit;
                          ImageList_DrawEx(FAlphaImageList.Handle, ImageIndex, BmpAm.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
                          LMDAlphaCopyRect2(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), BmpAm, 255);
                          BmpAm.Free;
                        end
                      else
                        LMDAlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
                    end
                  else
                    Canvas.BrushCopy(Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y),
                      BMP, Rect(0, 0, BMP.Width, BMP.Height), TC);
                end
              else
                begin
                  if FImageList is TLMDPNGImageList then
                    begin
//                      EK: to unify elmenu's and button's drawing
//                      LPNGFilter := TLMDPNGGrayscaleFilter.Create;
                      LPNGFilter := TLMDPNGAlphaBlendFilter.Create;
                      try
                        LPNGFilter.SourceImage := TLMDPNGImageList(FImageList).PNG[ImageIndex];
                        LPNGFilter.AlphaPercent := 40;
                        with GlyphPos do
                          LPNGFilter.ResultImage.Draw(Canvas, Rect(X, Y, X + FImageList.Width, Y + FImageList.Height));
                      finally
                        LPNGFilter.Free;
                      end;
                    end
                  else
                  begin
                      LMDSetDisabled(Bmp);
                      TC := Bmp.Canvas.Pixels[0, BMP.Height - 1];
                      Canvas.Brush.Color := TC;
                      Canvas.Brush.Style := bsClear;
                      LMDDrawTransparentBitmapEx(Canvas.Handle, Bmp, GlyphPos.X, GlyphPos.Y, Rect(0, 0, BMP.Width, BMP.Height), TC);
                    end;
                end;
                Canvas.Brush.Color := OTC;
                Canvas.Brush.Style := FStyle;
                Bmp.Free;
              end
            else
              if AlphaBlended then
                begin
                  BMP := TBitmap.Create;
                  BMP.Width := FImageList.Width;
                  Bmp.Height := FImageList.Height;
                  ImageList_DrawEx(FImageList.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
                  if AlphaIL then
                    begin
                      BmpAm := TBitmap.Create;
                      BmpAm.Width := FAlphaImageList.Width;
                      BmpAm.Height := FAlphaImageList.Height;
                      BmpAm.PixelFormat := pf32bit;
                      ImageList_DrawEx(FAlphaImageList.Handle, ImageIndex, BmpAm.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
                      LMDAlphaCopyRect2(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle,  Rect(0, 0, BMP.Width, BMP.Height), BmpAm, 255);
                      BmpAm.Free;
                    end
                  else
                    LMDAlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
                  Bmp.Free;
                end
              else
                with GlyphPos do
                  begin
                    if FImageList is TLMDPNGImageList then
                      FImageList.Draw(Canvas, X, Y, ImageIndex)
                    else
                  if Transparent or (State = ebsExclusive) or (Color = clNone) then
                        ImageList_DrawEx(FImageList.Handle, ImageIndex, Canvas.Handle, X, Y, 0, 0,
                          clNone, clNone, ILD_Transparent)
                      else
                        ImageList_DrawEx(FImageList.Handle, ImageIndex, Canvas.Handle, X, Y, 0, 0,
                          ColorToRGB(Color), clNone, ILD_Normal);
                  end; // of TLMDPNGImageList
        end;
      exit;
    end;

  if FUsePng then
    begin
      IcH := FPngGlyph.Height;
      IcW := FPngGlyph.Width;
      if (IcH > 0) and (IcW > 0) then
      begin
        if FStretched then
          FPngGlyph.Draw(Canvas, Rect(GlyphPos.X, GlyphPos.Y, GlyphPos.X + FStrW, GlyphPos.Y + FStrH))
        else
          FPngGlyph.Draw(Canvas, Rect(GlyphPos.X, GlyphPos.Y, GlyphPos.X + IcW, GlyphPos.Y + IcH));
      end;
      exit;
    end;

  if FUseIcon then
    begin
      GetIconInfo(Icon.Handle, IconInfo);
      GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
      IcH := ABMP.bmHeight;
      IcW := ABMP.bmWidth;
      if (IcH > 0) and (IcW > 0) then
      begin
        DeleteObject(IconInfo.hbmColor);
        DeleteObject(IconInfo.hbmMask);
        if FStretched then
          DrawIconEx(Canvas.Handle, GlyphPos.X, GlyphPos.Y, FIcon.Handle, FStrW, FStrH, 0, 0, DI_NORMAL)
        else
          DrawIconEx(Canvas.Handle, GlyphPos.X, GlyphPos.Y, FIcon.Handle, IcW, IcH, 0, 0, DI_NORMAL);
      end;
      exit;
    end;
  if (FOriginal = nil) or (FOriginal.Width = 0) or (FOriginal.Height = 0) then
    Exit;

  Index := CreateButtonGlyph(State, MaskUsage);
  AlphaBlended := not LMDIsAlphaEmpty(FOriginal);
  if FStretched then
    begin
      BMP := TBitmap.Create;
      BMP.Width := FOriginal.Width div FNumGlyphs;
      BMP.Height := FOriginal.Height;
      Bmp.PixelFormat := pf32bit;
      with GlyphPos do
        if Transparent or (State = ebsExclusive) then
          ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Transparent)
        else
          ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
            ColorToRGB(clBtnFace), clNone, ILD_Normal);
      FStyle := Canvas.Brush.Style;
      TC := BMP.Canvas.Pixels[0, BMP.Height - 1];
      OTC := Canvas.Brush.Color;
      Canvas.Brush.Color := TC;
      Canvas.Brush.Style := bsClear;
      if AlphaBlended then
        LMDAlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false)
      else
        Canvas.BrushCopy(Rect(GlyphPos.X, GlyphPos.Y, FStrW + GlyphPos.X, FStrH + GlyphPos.Y),
          BMP, Rect(0, 0, BMP.Width, BMP.Height), TC);
      Canvas.Brush.Color := OTC;
      Canvas.Brush.Style := FStyle;
      Bmp.Free;
    end
  else
    if AlphaBlended then
      begin
        BMP := TBitmap.Create;
        BMP.Width := FGlyphList.Width;
        Bmp.Height := FGlyphList.Height;
        Bmp.PixelFormat := pf32bit;
        ImageList_DrawEx(FGlyphList.Handle, Index, BMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Normal);
        LMDAlphaCopyRect(Canvas.Handle, Rect(GlyphPos.X, GlyphPos.Y, BMP.Width + GlyphPos.X, BMP.Height + GlyphPos.Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), 255, false);
        Bmp.Free;
      end
    else
      with GlyphPos do
        begin
          if Transparent or (State = ebsExclusive) or (Color = clNone) then
            ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
              clNone, clNone, ILD_Transparent)
          else
            ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
              ColorToRGB(Color), clNone, ILD_Normal);
        end;
end;

{$IFNDEF LMDCOMP7}{$O-}{$ENDIF}
procedure TLMDButtonGlyph.DrawButtonText(Canvas : TCanvas; const Caption :
    TLMDString; TextBounds : TRect; State : TLMDExButtonState; Multiline : boolean;
    Alignment : TAlignment; Active, Transparent : boolean; TextDrawType :
    TLMDTextDrawType; ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
    ShowAccelChar : boolean ; IsHTML : boolean; HTMLRender : TLMDHTMLRender ;
    ChangeDisabledText: boolean);
var
  Flags : integer;
{$ifdef LMD_UNICODE}
{$ifdef LMD_ELUNISCRIBE}
  FPlainText: TLMDString;
{$endif}
{$endif}
begin
  if IsHTML then
  begin
    HTMLRender.DrawText(Canvas, Point(0, 0), TextBounds, clNone);
  end
  else
  if (ThemeMode <> ttmNone) then
  begin
    if not Multiline then
      Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE
    else
    begin
      Flags := 0;
      case Alignment of
        taLeftJustify: Flags := DT_LEFT;
        taRightJustify: Flags := DT_RIGHT;
        taCenter: Flags := DT_CENTER;
      end;
      Flags := Flags or DT_VCENTER;
    end;
    if not ShowAccelChar then
      Flags := Flags or DT_NOPREFIX;
    Canvas.Brush.Style := bsClear;
    LMDThemeServices.DrawThemeText(ThemeMode, Canvas.Handle, Details, int_RefW(WideString(Caption)), Length(WideString(Caption)), Flags, 0, TextBounds); //vb !!!
  end
  else
  with Canvas do
  begin
    Brush.Style := bsClear;
    if (State = ebsDisabled) and ChangeDisabledText then
    begin
      OffsetRect(TextBounds, 1, 1);
      if not Multiline then
        Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS
      else
        Flags := DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;
      Font.Color := clBtnHighlight;
      if Transparent then Brush.Style := bsClear;
      LMDDrawText(Handle, Caption, Length(Caption), TextBounds, Flags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      LMDDrawText(Handle, Caption, Length(Caption), TextBounds, Flags);
      end
    else
    begin
      if not Multiline then
        Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS
      else
        Flags := DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;
      if Transparent then Brush.Style := bsClear;
      {$ifdef LMD_UNICODE}
      {$ifdef LMD_ELUNISCRIBE}
      FUniscribeString.Text := Caption;
      FPlainText := FUniscribeString.PlainText;
      if ScriptIsComplex(PWideChar(FPlainText), Length(FPlainText), SIC_COMPLEX) = S_FALSE then
      begin
      {$endif}
      {$endif}
        {$ifdef LMD_UNICODE}
        LMDDrawTypedTextW(Canvas, TextBounds, Caption, Flags, TextDrawType);
        {$else}
        LMDDrawTypedText(Canvas, TextBounds, Caption, Flags, TextDrawType);
        {$endif}
     {$ifdef LMD_UNICODE}
     {$ifdef LMD_ELUNISCRIBE}
      end
      else
      begin
        FUniscribeString.PrepareText(Canvas,TextBounds.Right - TextBounds.Left, Multiline);
        FUniscribeString.DrawText(Canvas, TextBounds, Flags);
      end;
      {$endif}
      {$endif}

      Brush.Style := bsSolid;
      case TextDrawType of
        tdtNormal: InflateRect(TextBounds, 1, 1);
        tdtShadowed: InflateRect(TextBounds, 3, 3);
        tdtRaised: InflateRect(TextBounds, 2, 2);
      end;
      //if Active and (Length(Caption) > 0) then Windows.DrawFocusRect(Canvas.Handle, TextBounds);
    end;
  end;
end;
{$IFNDEF LMDCOMP7}{$O+}{$ENDIF}
{$WARNINGS off}

procedure TLMDButtonGlyph.CalcButtonLayout(Canvas : TCanvas; const Client :
    TRect; const OffsetSize : TPoint; const Caption : TLMDString; Layout :
    TButtonLayout; Margin, Spacing : Integer; var GlyphPos : TPoint; var
    TextBounds : TRect; ShowGlyph, ShowText, MultiLine : boolean; ArrowWidth :
    integer; ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
    ShowAccelChar : boolean;  IsHTML : boolean; HTMLRender : TLMDHTMLRender; Alignments: TAlignment);
var
  TextPos : TPoint;
  ClientSize, GlyphSize, TextSize : TPoint;
  TotalSize : TPoint;
  GX, GY : integer;
  Flags : integer;
  AGraphic : TGraphic;
  IcW, IcH : Integer;
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;
  ILBitmap : TBitmap;
begin
  ClientSize := Point(Client.Right - Client.Left - ArrowWidth, Client.Bottom - Client.Top);
  FStretched := false;

  if UseImageList and (FImageList <> nil) then
  begin
    ILBitmap := TBitmap.Create;
    if FImageIndex <> -1 then
    begin
      ILBitmap.Height := ImageList.Height;
      ILBitmap.Width := ImageList.Width;
    end;
    AGraphic := ILBitmap;
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    IcH := ABMP.bmHeight;
    IcW := ABMP.bmWidth;
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    AGraphic := FIcon;
    end
  else
    if FUsePng then
      AGraphic := FPngGlyph
    else
      AGraphic := FOriginal;
  if (AGraphic <> nil) and (ShowGlyph) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end
    else
    if AGraphic = ILBitmap then
    begin
      GX := AGraphic.Width;
      GY := AGraphic.Height;
    end
    else
    begin
      if FUsePng then
        GX := AGraphic.Width
      else
        GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;
    if GY > ClientSize.y then
    begin
      GX := MulDiv(GX, ClientSize.Y - 2, GY);
      GY := ClientSize.Y - 2;
//      GX := MulDiv(GX, GY, ClientSize.Y);
      FStretched := true;
    end;
    if GX > ClientSize.X then
    begin
      GY := MulDiv(GY , ClientSize.x - 4, GX);
      GX := ClientSize.x - 2;
      FStretched := true;
    end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    GlyphSize := Point(GX, GY);
  end
  else
    GlyphSize := Point(0, 0);

  if (Length(Caption) > 0) and (ShowText) then
  begin
    if IsHTML then
    begin
      HTMLRender.PrepareText(Caption, 0, false);
      TextBounds := Rect(0, 0, HTMLRender.Data.TextSize.cx, HTMLRender.Data.TextSize.cy);
      with HTMLRender.Data.TextSize do
        TextSize := Point(cx, cy);
    end
    else
    if (ThemeMode <> ttmNone) then
    begin
      TextBounds := Rect(0, 0, ClientSize.X, 0);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;
      LMDThemeServices.GetThemeTextExtent(ThemeMode, Canvas.Handle, Details.Element, Details.Part, Details.State, int_RefW(WideString(Caption)), Length(WideString(Caption)), Flags, LMDRectToPtr(Client), TextBounds);
      OffsetRect(TextBounds, -TextBounds.Left, -TextBounds.Top);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
    end
    else
    begin
      TextBounds := Rect(0, 0, ClientSize.X, 0);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;

      LMDDrawText(Canvas.Handle, Caption, Length(Caption), TextBounds, Flags);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end;
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := 0{(ClientSize.Y - TotalSize.Y) div 3};
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 2
      else
        Margin := 0 {(ClientSize.Y - TotalSize.Y) div 2};
    end;
  end
  else
  begin
    if Spacing <> -1 then
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
    end;
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := 0{(TotalSize.Y - TextSize.Y) div 2};
    end;
  end;

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y {+ 1}) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y {+ 1}) div 2;
  end
  else
  begin
    case Alignments of
      taLeftJustify:
      begin
        GlyphPos.X := {Margin +} Client.Left;
        TextPos.X := {Margin +} Client.Left;
      end;
      taRightJustify:
      begin
        GlyphPos.X := Client.Right - GlyphSize.X {- Margin};
        TextPos.X := Client.Right - TextSize.X {- Margin};
      end;
    else
      begin
        GlyphPos.X := (ClientSize.X - GlyphSize.X) div 2 + Client.Left;
        TextPos.X := (ClientSize.X - TextSize.X) div 2 + Client.Left;
      end;
    end;
  end;

  case Layout of
    blGlyphLeft :
      begin
        case Alignments of
          taLeftJustify: GlyphPos.X := Margin + Client.Left;
          taRightJustify: GlyphPos.X := Client.Right - TotalSize.X;
        else
          GlyphPos.X := ((ClientSize.X - TotalSize.X) div 2) + Client.Left;
        end;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRight :
      begin
        case Alignments of
          taLeftJustify: GlyphPos.X := Client.Left + TextSize.X + Margin + Spacing;
          taRightJustify: GlyphPos.X := Client.Right - Margin - GlyphSize.X;
        else
          GlyphPos.X := Client.Right - max(0, ((ClientSize.X - TotalSize.X) div 2)) - GlyphSize.X;
        end;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop :
      begin
        GlyphPos.Y := ((ClientSize.Y - TotalSize.Y) div 2) + Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + max(Spacing, 0);
      end;
    blGlyphBottom :
      begin
        TextPos.Y := ((ClientSize.Y - TotalSize.Y) div 2) + Margin;
        GlyphPos.Y := TextPos.Y + max(Spacing, 0) + TextSize.Y;
      end;
  end;

  { fixup the result variables }
  with GlyphPos do
  begin
    Inc(X, OffsetSize.X);
    Inc(Y, Client.Top + OffsetSize.Y);
  end;
    OffsetRect(TextBounds, TextPos.X {+ Client.Left} + OffsetSize.X, TextPos.Y + Client.Top + OffsetSize.Y);
  if UseImageList and (FImageList <> nil) then ILBitmap.Free;
end;

procedure TLMDButtonGlyph.GetPaintGlyphSize(R : TRect; var Size : TPoint);
var
  GX, GY : integer;
  ClientSize : TPoint;
  AGraphic : TGraphic;
  IcW,
    IcH : Integer;
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;
  ILBitmap : TBitmap;
begin
  AGraphic := nil;
  ClientSize.X := R.Right - R.Left;
  ClientSize.Y := R.Bottom - R.Top;
  if UseImageList and (FImageList <> nil) then
  begin
    ILBitmap := TBitmap.Create;
    if FImageIndex <> -1 then
    begin
      ILBitmap.Height := ImageList.Height;
      ILBitmap.Width := ImageList.Width;
      AGraphic := ILBitmap;
    end;
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, SizeOf(ABMP), @ABMP);
    IcH := ABMP.bmHeight;
    IcW := ABMP.bmWidth;
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    AGraphic := FIcon;
    end
  else
    AGraphic := FOriginal;
  if (AGraphic <> nil) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end
    else
    begin
      GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;
    if GY > ClientSize.Y then
    begin
      GX := MulDiv(GX, ClientSize.Y - 2, GY);
      GY := ClientSize.Y - 2;
//      GX := MulDiv(GX, GY, ClientSize.Y);
//      GX := Trunc(GX * (GY / ClientSize.Y));
      if FResizable then
        FStretched := true;
    end;
    if GX > ClientSize.X then
    begin
      GY := MulDiv(GY, ClientSize.x - 4, GX);
      GX := ClientSize.X - 2;
      if FResizable then
        FStretched := true;
    end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    Size := Point(GX, GY);
  end
  else
    Size := Point(0, 0);
  if UseImageList and (FImageList <> nil) then
    ILBitmap.Free;
end;

function TLMDButtonGlyph.Draw(Canvas : TCanvas; const Client : TRect; const
    Offset : TPoint; const Caption : TLMDString; Layout : TButtonLayout; Margin,
    Spacing : Integer; State, GlyphState : TLMDExButtonState; Alignment : TAlignment;
    Transparent : Boolean; Multiline : boolean; Active, ShowGlyph, ShowText : boolean;
    ArrowWidth : integer; TextDrawType : TLMDTextDrawType; Color : TColor;
    ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
    ShowAccelChar : boolean; ImageIsAlphaBlended : boolean
    ; IsHTML : boolean; HTMLRender : TLMDHTMLRender; ChangeDisabledText : boolean;
    MaskUsage: TLMDGlyphListMaskUsage = muGlyphList): TRect;
var
  GlyphPos : TPoint;
begin
  if Margin = -1 then
    Alignment := taCenter; // see TBitBtn.Margin help topic for information
  CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing,
    GlyphPos, Result, ShowGlyph, ShowText, Multiline, ArrowWidth, ThemeMode,
    Details, ShowAccelChar , IsHTML, HTMLRender,Alignment);
  if ShowGlyph then
     DrawButtonGlyph(Canvas, GlyphPos, GlyphState, Transparent, Color, ImageIsAlphaBlended, MaskUsage);
  if ShowText then
    DrawButtonText(Canvas, Caption, Result, State, MultiLine, Alignment, Active,
      Transparent, TextDrawType, ThemeMode, Details, ShowAccelChar, IsHTML, HTMLRender, ChangeDisabledText);
end;

procedure TLMDButtonGlyph.SetUseIcon(NewValue : boolean);
begin
  if newValue <> FUseIcon then
  begin
    FUseIcon := NewValue;
    Repaint;
  end;
end;

procedure TLMDButtonGlyph.SetUsePng(const Value: boolean);
begin
  FUsePng := Value;
end;

function TLMDButtonGlyph.GetGlyphSize : TRect;

var
  IconInfo : TIconInfo;
  ABMP : Windows.TBitmap;

begin
  if FUseImageList then
  begin
    result := Rect(0, 0, FImageList.Width, FImageList.Height);
  end
  else
  if UseIcon then
  begin
    GetIconInfo(Icon.Handle, IconInfo);
    GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
    result := Rect(0, 0, ABMP.bmWidth, ABMP.bmHeight);
    DeleteObject(IconInfo.hbmColor);
    DeleteObject(IconInfo.hbmMask);
    end
  else
    result := Rect(0, 0, FOriginal.Width div FNumGlyphs, FOriginal.Height);
end;

function TLMDButtonGlyph.CalcButtonWidth(Canvas : TCanvas; var MaxHeight :
    integer; const Offset : TPoint; const Caption : TLMDString; Layout :
    TButtonLayout; Margin, Spacing : Integer; ShowGlyph, ShowText, MultiLine :
    boolean; ArrowWidth : integer; ThemeMode: TLMDThemeMode; Details: TThemedElementDetails;
   ShowAccelChar : boolean; IsHTML : boolean; HTMLRender : TLMDHTMLRender): Integer;
var AGraphic : TGraphic;
    IcW,
      IcH : Integer;
    IconInfo : TIconInfo;
    ABMP     : Windows.TBitmap;
    ILBitmap : TBitmap;
    // Spacing  : integer;
    GX, GY   : integer;
    TextSize,
    GlyphSize: TPoint;
    Client,
    TextBounds: TRect;
    Flags    : integer;
    begin
  // first get the graphic that will be used as a glyph
  if ShowGlyph then
  begin
    if UseImageList and (FImageList <> nil) then
    begin
      ILBitmap := TBitmap.Create;
      if FImageIndex <> -1 then
      begin
        ILBitmap.Height := ImageList.Height;
        ILBitmap.Width := ImageList.Width;
      end;
      AGraphic := ILBitmap;
    end
    else
    if UseIcon then
    begin
      GetIconInfo(Icon.Handle, IconInfo);
      GetObject(IconInfo.hbmColor, sizeof(ABMP), @ABMP);
      IcH := ABMP.bmHeight;
      IcW := ABMP.bmWidth;
      DeleteObject(IconInfo.hbmColor);
      DeleteObject(IconInfo.hbmMask);
      AGraphic := FIcon;
      end
    else
      if UsePng then
        AGraphic := FPngGlyph
      else
        AGraphic := FOriginal;
  end
  else
    AGraphic := nil;

  // determine actual graphic size
  if (AGraphic <> nil) then
  begin
    if UseIcon then
    begin
      GX := IcW;
      GY := IcH;
    end
    else
    if AGraphic = ILBitmap then
    begin
      GX := AGraphic.Width;
      GY := AGraphic.Height;
    end
    else
    begin
      GX := AGraphic.Width div FNumGlyphs;
      GY := AGraphic.Height;
    end;

    if MaxHeight <> 0 then
      if GY > MaxHeight then
      begin
        GY := MaxHeight - 2;
        GX := MulDiv(GX, GY, MaxHeight);
        if FResizable then
          FStretched := true;
      end;
    if FStretched then
    begin
      FStrW := GX;
      FStrH := GY;
    end;
    GlyphSize := Point(GX, GY);
  end
  else
    GlyphSize := Point(0, 0);

  // calculate text size
  if (Length(Caption) > 0) and (ShowText) then
  begin
    if IsHTML then
    begin
      HTMLRender.PrepareText(Caption, 0, false);
      TextBounds := Rect(0, 0, HTMLRender.Data.TextSize.cx, HTMLRender.Data.TextSize.cy);
      with HTMLRender.Data.TextSize do
        TextSize := Point(cx, cy);
    end
    else
    if (ThemeMode <> ttmNone) then
    begin
      TextBounds := Rect(0, 0, 10000, 10000);
      if MultiLine then
        Flags := 0
      else
        Flags := DT_SINGLELINE;
      LMDThemeServices.GetThemeTextExtent(ThemeMode, Canvas.Handle, Details.Element, Details.Part, Details.State, int_RefW(WideString(Caption)), Length(WideString(Caption)), Flags, LMDRectToPtr(Client), TextBounds);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
    end
    else
    begin
      TextBounds := Rect(0, 0, 10000, 10000);
      if MultiLine then
        Flags := DT_CALCRECT
      else
        Flags := DT_CALCRECT + DT_SINGLELINE;
      if not ShowAccelChar then
        Flags := Flags or DT_NOPREFIX;

      LMDDrawText(Canvas.Handle, Caption, Length(Caption), TextBounds, Flags);
      TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
        TextBounds.Top);
    end;
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0
  else
  if Spacing = -1 then
    Spacing := 2;

  if Margin = -1 then
    Margin := 2;

  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
     result := TextSize.X + GlyphSize.X + Margin * 2 + Spacing;
     if MaxHeight = 0 then
       MaxHeight := Max(TextSize.Y, GlyphSize.Y) + Margin * 2;
  end
  else
  begin
     result := Max(TextSize.X, GlyphSize.X) + Margin * 2;
     if MaxHeight = 0 then
       MaxHeight := TextSize.Y + GlyphSize.Y + Margin * 2 + Spacing;
  end;
  inc(Result, ArrowWidth);
  if ShowGLyph and UseImageList and (FImageList <> nil) then
    ILBitmap.Free;
end;

end.
