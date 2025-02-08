unit LMDFillObject;
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

LMDFillObject unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, LMDGraph, LMDShapeFill;

type
  {for all components without own Brush property}
  {----------------------TLMDFillObject--------------------------------------}
  TLMDFillOption=(foFillInner, foQuickDraw, foGrUseBitmap);
  TLMDFillOptions=set of TLMDFillOption;

  TLMDFillObject=class(TLMDShapeFill)
   private
     FAlignment:TLMDAlignment;
     FOffsetX,
     FOffsetY:Integer;
     FBrush:TBrush;
     FOptions:TLMDFillOptions;
     FAlphaLevel: Byte;
     procedure SetAlignment(aValue:TLMDAlignment);
     procedure SetBrush(aValue:TBrush);
     procedure SetInteger(Index, aValue:Integer);
     procedure SetOptions(aValue:TLMDFillOptions);
     function GetTransparent:Boolean;
     procedure SetAlphaLevel(const Value: Byte);
   protected
   public
     constructor Create(AOwner:TPersistent=nil);override;
     destructor Destroy;override;
     procedure Assign(Source:TPersistent);override;
     function ClipFill(aCanvas:TCanvas; aRect:TRect; orgC:TColor; pos:LongInt):Boolean;
     function FillCanvas(aCanvas:TCanvas; aRect:TRect; orgC:TColor):Boolean;
     property Transparent:Boolean read GetTransparent;
   published
     property AlphaLevel: Byte read FAlphaLevel write SetAlphaLevel default 255;  //RM: 27-Jan-2010, Constructor sets to 255
     property Alignment:TLMDAlignment read FAlignment write SetAlignment default agTopLeft;
     property Brush:TBrush read FBrush write SetBrush;
     property OffsetX:Integer index 0 read FOffsetX write SetInteger default 0;
     property OffsetY:Integer index 1 read FOffsetY write SetInteger default 0;
     property Options:TLMDFillOptions read FOptions write SetOptions default
                                     [foFillInner, foGrUseBitmap];
     property Style default sfNone;
   end;

implementation
uses
  SysUtils, Types, LMDPNGImage, LMDGraphUtils, LMDSysIn;

{------------------------- Private --------------------------------------------}
procedure TLMDFillObject.SetAlignment(aValue:TLMDAlignment);
begin
  if FAlignment<>aValue then
    begin
      FAlignment:=aValue;
      if (Style in [sfBitmap, sfBitmapList]) and (TileMode=tmNone) then Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObject.SetAlphaLevel(const Value: Byte);
begin
  FAlphaLevel := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObject.SetBrush(aValue:TBrush);
begin
  FBrush.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObject.SetInteger(Index, aValue:Integer);
begin
  case index of
    0: if aValue=FOffsetX then exit else FOffsetX:=aValue;
    1: if aValue=FOffsetY then exit else FOffsetY:=aValue;
  end;
  if (Style in [sfBitmap, sfBitmapList]) and (TileMode=tmNone) then Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObject.SetOptions(aValue:TLMDFillOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFillObject.GetTransparent;
begin
  result:=False;
  case Style of
    sfNone:result:=True;
    sfBrush:result:=(Brush.Style<>bsSolid) and not (foFillInner in FOptions);
    sfBitmap, sfBitmapList:
      case TileMode of
        tmNone, tmCenter:result:=not (foFillInner in FOptions);
      end;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDFillObject.Create;
begin
  inherited Create;
  FBrush:=TBrush.Create;
  FOptions:=[foFillInner, foGrUseBitmap];
  FAlphaLevel := 255;
  BeginUpdate;
  Style:=sfNone;
  FAlignment:=agTopLeft;
  EndUpdate(false);
  FBrush.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDFillObject.Destroy;
begin
  FBrush.OnChange:=nil;
  FBrush.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObject.Assign(Source:TPersistent);
var
  S: TLMDFillObject;
begin
  if Source=self then exit;
  if Source is TLMDFillObject then
    begin
      S := TLMDFillObject(Source);
      BeginUpdate;
      FBrush.Assign(S.Brush);
      FOptions:=S.Options;
      Bitmap.Assign(S.Bitmap);
      FListBitmap.Assign(S.ListBitmap);
      Gradient.Assign(S.Gradient);
      Style:=S.Style;
      TileMode:=S.TileMode;
      EndUpdate(True);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDFillObject.ClipFill(aCanvas:TCanvas; aRect:TRect; orgC:TColor;
                                 pos:LongInt):Boolean;
var
  Rgn:HRgn;

begin
  result:=false;
  if (Style=sfGradient) and (foGrUseBitmap in FOptions) then
    FillCanvas(aCanvas, aRect, orgC)
  else
    begin
      if pos=0 then
        Rgn:=CreateRectRgnIndirect(aRect)
      else
        with aRect do
         Rgn:=CreateRectRgn(LoWord(pos)+Left, HiWord(pos)+Top,
                            LoWord(pos)+Right, HiWord(pos)+Bottom);
      try
        SelectClipRgn(aCanvas.Handle, Rgn);
        result:=FillCanvas(aCanvas, aRect, orgc);
      finally
        DeleteObject(Rgn);
        SelectClipRgn(aCanvas.Handle, 0);
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFillObject.FillCanvas(aCanvas:TCanvas; aRect:TRect; orgC:TColor):Boolean;
var
  flag:Word;
  tmp:TBitmap;
  dRect:TRect;
  LTileBmp: TBitmap;
  LRect: TRect;
  LCanvas: TCanvas;
  LOffScreen: TBitmap;
  LWidth, LHeight: Integer;

  procedure Fill;
  begin
    if foFillInner in FOptions then
    begin
      with LCanvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := orgC;
        FillRect(LRect);
      end;
    end;
  end;

begin
  result:=True;
  tmp:=nil;
  LOffScreen := nil;
  if FAlphaLevel < 255 then
  begin
    LWidth := aRect.Right - aRect.Left;
    LHeight := aRect.Bottom - aRect.Top;
    if (LWidth > 0) and (LHeight > 0) then
    begin
      LOffScreen := TBitmap.Create;
      LOffScreen.Width := LWidth;
      LOffScreen.Height := LHeight;
      LRect := Rect(0, 0, LWidth, LHeight);
      LCanvas := LOffScreen.Canvas;
    end
    else
    begin
      LCanvas := aCanvas;
      LRect := aRect;
    end;
  end
  else
  begin
    LCanvas := aCanvas;
    LRect := aRect;
  end;
  try
    with LCanvas do
    begin
      case Style of
        sfBrush:
          begin
             Brush := self.Brush;
             pen.Color:=orgC;
             if Brush.Style <> bsSolid then
               SetBKColor(Handle, ColorToRGB(orgc));
             FillRect(LRect);
          end;
        sfBrushBitmap:
          try
            if not Bitmap.Empty then
              if LMDSIWindowsNT then
                Brush.Bitmap:=Bitmap
              else
                begin
                  tmp:=TBitmap.Create;
                  tmp.Width:=8;
                  tmp.Height:=8;
                  tmp.Canvas.CopyRect(Types.Rect(0,0,8,8), Bitmap.Canvas,Rect(0,0,8,8));
                  Brush.Bitmap:=tmp;
                end;
            FillRect(LRect);
          finally
            if tmp<>nil then tmp.Free;
            Brush.Bitmap:=nil;
          end;
        sfBitmap, sfBitmapList:
          begin
            if Style=sfBitmap then
              tmp:=Bitmap
            else
              tmp:=FListBitmap;
            if tmp.Empty then
              begin
                Fill;
                result:=False
              end
            else
              begin
                flag:=0;
                if not (foQuickDraw in FOptions) then
                  flag:=DSF_PALETTEREALIZE;

                case TileMode of
                  tmStretch:LMDBmpDraw(LCanvas, LRect, tmp, flag or DSF_STRETCH, clBlack);
                  tmHorizontalTile:
                  begin
                    LTileBmp := TBitmap.Create;
                    LTileBmp.Width := tmp.Width;
                    LTileBmp.Height := LRect.Bottom - LRect.Top;
                    LMDBmpDraw(LTileBmp.Canvas, Rect(LRect.Left, LRect.Top, LRect.Left + tmp.Width, LRect.Bottom), tmp, DSF_STRETCH, clBlack);
                    LMDBmpDraw(LCanvas, LRect, LTileBmp, flag or  DSF_TILE, clBlack);
                    LTileBmp.Free;
                  end;
                  tmVerticalTile:
                  begin
                    LTileBmp := TBitmap.Create;
                    LTileBmp.Width := LRect.Right - LRect.Left; 
                    LTileBmp.Height := tmp.Height;
                    LMDBmpDraw(LTileBmp.Canvas, Rect(LRect.Left, LRect.Top, LRect.Right, LRect.Top + tmp.Height), tmp, DSF_STRETCH, clBlack);
                    LMDBmpDraw(LCanvas, LRect, LTileBmp, flag or  DSF_TILE, clBlack);
                    LTileBmp.Free;
                  end;
                  tmTile:LMDBmpDraw(LCanvas, LRect, tmp, flag or  DSF_TILE, clBlack);
                  tmNone:
                    begin
                      Fill;
                      dRect:=LMDAlignRect(FAlignment, Rect(0,0, tmp.Width, tmp.Height), LRect);
                      OffsetRect(dRect, FOffsetX, FOffsetY);
                      LMDBmpDraw(LCanvas, dRect, tmp, flag, clBlack);
                    end;
                   tmCenter:
                    begin
                      Fill;
                      LMDBmpDraw(LCanvas, LRect, tmp, flag or DSF_CENTER, clBlack);
                    end;
                end;
              end;
          end;
        sfGradient:
          with Gradient do
            begin
              flag:=0;
              if foGrUseBitmap in FOptions then flag:=DSF_USEOFFSCREENBITMAP;
              if PaletteRealize then flag:=flag or DSF_PaletteRealize;
              LMDGradientPaintExt(LCanvas, LRect, Style, ColorList, Palette, flag, 0);
            end;
        sfPng:
          begin
            case TileMode of
              tmNone: Png.Draw(LCanvas, LRect);
              tmCenter: ;
              tmStretch: Png.Draw(LCanvas, LRect);
              tmTile: ;
            end;
          end;
      else
        result:=False;
      end;
    end;
    if (Result) and (FAlphaLevel < 255) and (Assigned(LOffScreen)) then
    begin
      LMDAlphaCopyRect(aCanvas.Handle, aRect, LCanvas.Handle, LRect, FAlphaLevel, True);
    end;
  finally
    if Assigned(LOffScreen) then
      FreeAndNil(LOffScreen);
  end;
end;

end.
