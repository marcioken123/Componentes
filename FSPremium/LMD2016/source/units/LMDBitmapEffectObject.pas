unit LMDBitmapEffectObject;
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

LMDBitmapEffectObject unit (JH)
-------------------------------
Special object for supporting alpha blending

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, LMDObject, LMDGraph, LMDAlphaObject, LMDBmp;

type
  TLMDBitmapEffectObject = class(TLMDObject)
  private
    FAlphaObject : TLMDAlphaObject;
    FBufferValid,
    FInvert,
    FBuffered,
    FGrayScale,
    FFlipVert,
    FMonochrome,
    FFlipHoriz   : Boolean;
    FBitmap      : TBitmap;
    FBrightness  : TLMDBrightness;

    procedure SetAlphaObject (aValue : TLMDAlphaObject);
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetBrightness (aValue : TLMDBrightness);

  protected
    procedure GetChange (Sender : TObject); override;
  public
    constructor Create(AOwner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
    function GetSetStr : String; override;

    function Enabled : Boolean;

    //directly change target bitmap
    procedure Draw (target : TBitmap);

    //draw on whole image source must have same size as target
    procedure DrawCopy (source, target : TBitmap);

    //draw source rect on whole image target  (target bitmap size = sourceRect size)
    procedure DrawCopyFromRect (source : TBitmap; sourceRect : TRect; target : TBitmap);

    //draw source rect on target at pos targetPt
    procedure DrawCopyRect (source : TBitmap; sourceRect : TRect; target : TBitmap; targetPt : TPoint);

    //source = whole back; sourcerect = piece of whole to be modified
    //traget = whole target bitmap; tragetRect = rect in traget which shall be painted
    //effect is calculated for whole target but only targetRect is painted

    procedure DrawCutRect (source : TBitmap; sourceRect : TRect; //source image (rect)
                           target : TBitmap; targetRect : TRect);

    procedure DrawCutRect2 (source : TBitmap; sourceRect : TRect; //source image (rect)
                            target : TBitmap; targetRect : TRect);

    procedure DestroyBuffer;

    property BufferBitmap : TBitmap read FBitmap;
    property BufferValid : Boolean read FBufferValid;
  published
    property AlphaBlend : TLMDAlphaObject read FAlphaObject write SetAlphaObject;
    property FlipVertical : Boolean index 0 read FFlipVert write SetBoolean default false;
    property FlipHorizontal : Boolean index 1 read FFlipHoriz write SetBoolean default false;
    property GrayScale : Boolean index 2 read FGraySCale write SetBoolean default false;
    property Invert : Boolean index 3 read FInvert write SetBoolean default false;
    property Buffered : Boolean index 4 read FBuffered write SetBoolean default false;
    property Brightness : TLMDBrightness read FBrightness write SetBrightness default 0;
//    property Monochrome : Boolean index 5 read FMonochrome write SetBoolean default false;
  end;

implementation

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.SetAlphaObject (aValue : TLMDAlphaObject);
begin
  FAlphaObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : if aValue <> FFlipVert then
          begin
            FFlipVert := aValue;
            GetChange (nil);
          end;
    1 : if aValue <> FFlipHoriz then
          begin
            FFlipHoriz := aValue;
            GetChange (nil);
          end;
    2 : if aValue <> FGrayScale then
          begin
            FGrayScale := aValue;
            GetChange (nil);
          end;
    3 : if aValue <> FInvert then
          begin
            FInvert := aValue;
            GetChange (nil);
          end;
    4 : if aValue <> FBuffered then
          begin
            FBuffered := aValue;
            FBufferValid := false;
            if FBuffered then
              FBitmap := TBitmap.Create
            else
              if FBitmap <> nil then
                begin
                  FBitmap.Free;
                  FBitmap := nil;
                end;
            GetChange (nil);
          end;
    5 : if aValue <> FMonochrome then
          begin
            FMonochrome := aValue;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.SetBrightness (aValue : TLMDBrightness);
begin
  if aValue <> FBrightness then
    begin
      FBrightness := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  DestroyBuffer;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDBitmapEffectObject.Create;
begin
  inherited Create;

  FAlphaObject := TLMDAlphaObject.Create;
  FAlphaObject.OnChange := GetChange;

  FFlipVert := false;
  FFlipHoriz := false;
  FGrayScale := false;
  FInvert := false;
  FMonochrome := false;
  FBuffered := false;
  FBufferValid := false;
  FBrightness := 0;
  FBitmap := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBitmapEffectObject.Destroy;
begin
  if FBitmap <> nil then
    begin
      FBitmap.Free;
      FBitmap := nil;
    end;
  FAlphaObject.OnChange := nil;
  FAlphaObject.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.Assign (Source : TPersistent);
var
  S: TLMDBitmapEffectObject;
begin
  if Source = self then Exit;
  if Source is TLMDBitmapEffectObject then
    begin
      S := TLMDBitmapEffectObject(Source);
      FFlipVert := S.FlipVertical;
      FFlipHoriz := S.FlipHorizontal;
      FGrayScale := S.GrayScale;
      FInvert := S.Invert;
      FBrightness := S.Brightness;
//      FMonochrome := (Source as TLMDBitmapEffectObject).Monochrome;
      Buffered := S.Buffered;
      FAlphaObject.Assign (S.AlphaBlend);
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBitmapEffectObject.GetSetStr : String;

  procedure add (s : String);
  begin
    if result = '' then
      result := s
    else
      result := result +','+ s;
  end;

begin
  result := '';
  if FAlphaObject.FillObject.Style <> sfNone then add ('alpha');
  if FFlipVert then add('FV');
  if FFlipHoriz then add('FH');
  if FGrayScale then add('GS');
  if FInvert then add('INV');
  if FBrightness <> 0 then add ('B');
  if result = '' then result := 'Disabled';
  result := '{' + result + '}';
end;

{ ---------------------------------------------------------------------------- }
function TLMDBitmapEffectObject.Enabled : Boolean;
begin
  result := FFlipVert or FFlipHoriz or FGrayScale or FInvert or FAlphaObject.Enabled or (FBrightness <> 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.Draw (target : TBitmap);
begin
  if FBuffered and FBufferValid then
    begin
      target.Canvas.Draw (0, 0, FBitmap);
      exit;
    end;
  if FFLipVert then
    LMDBmpFlipVertical (target, Rect (0, 0, target.Width - 1, target.Height - 1), target, Point (0,0));
  if FFLipHoriz then
    LMDBmpFlipHorizontal (target, Rect (0, 0, target.Width - 1, target.Height - 1), target, Point (0,0));
  if FGrayScale then
    LMDBmpGrayScale (target, Rect (0, 0, target.Width - 1, target.Height - 1), target, Point (0,0));
  if FInvert then
    LMDBmpInvert (target, Rect (0, 0, target.Width - 1, target.Height - 1), target, Point (0,0));
  if FMonochrome then
    target.Monochrome := true;
  if FBrightness <> 0 then
    LMDBmpBrightness (target, Rect (0, 0, target.Width, target.Height), target, Point (0,0), FBrightness);

  FAlphaObject.AlphaBlend (target);

  if FBuffered and not FBufferValid then
    begin
      FBitmap.Canvas.Draw (0,0, target);
      FBufferValid := true;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DrawCopy (source, target : TBitmap);
begin
  target.Canvas.CopyRect (Rect (0, 0, source.Width-1, source.Height-1), source.canvas, Rect (0, 0, source.Width-1, source.Height-1));
  Draw (target);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DrawCopyFromRect (source : TBitmap; sourceRect : TRect; target : TBitmap);
begin
  target.Canvas.CopyRect (Rect (0, 0, sourceRect.Right - sourceRect.Left, sourceRect.Bottom - sourceRect.Top), source.canvas, sourceRect);
  Draw (target);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DrawCopyRect (source : TBitmap; sourceRect : TRect; target : TBitmap; targetPt : TPoint);
begin

  if FBuffered and FBufferValid then
    begin
      target.Canvas.Draw (0, 0, FBitmap);
      exit;
    end;

  //get whole image to target
  target.Canvas.CopyRect (Rect (targetPt.X, targetPt.Y, targetPt.X + sourceRect.Right - sourceRect.Left, targetPt.Y + sourceRect.Bottom - sourceRect.Top),
                          source.canvas, sourceRect);

  if FFLipVert then
    LMDBmpFlipVertical (source, sourceRect, target, targetPt);
  if FFLipHoriz then
    LMDBmpFlipHorizontal (source, sourceRect, target, targetPt);
  if FGrayScale then
    LMDBmpGrayScale (source, sourceRect, target, targetPt);
  if FInvert then
    LMDBmpInvert (source, sourceRect, target, targetPt);
  if FBrightness <> 0 then
    LMDBmpBrightness (target, sourceRect, target, targetPt, FBrightness);

  if FBuffered and not FBufferValid then
    begin
      FBitmap.Canvas.Draw (0,0, target);
      FBufferValid := true;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DrawCutRect (source : TBitmap; sourceRect : TRect; //source image (rect)
                                              target : TBitmap; targetRect : TRect);
var
  b : TBitmap;
begin

  //target = small piece of whole image
  //targetRect -> small piece of image in sourcerect

  //source = complete image
  //sourcerect = complete controls rects

  b := TBitmap.Create;
  try
    b.Width := sourceRect.Right - sourceRect.Left;
    b.Height := sourceRect.Bottom - sourceRect.Top;
    b.PixelFormat := pf24Bit;

    b.Canvas.CopyRect (b.Canvas.ClipRect, source.Canvas, sourceRect);

    Draw(b);

    //complete back
    target.Canvas.CopyRect (target.Canvas.ClipRect, source.Canvas, sourceRect);

    //get modified piece
    target.Canvas.CopyRect (targetRect, b.Canvas, targetRect);
  finally
    b.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DrawCutRect2 (source : TBitmap; sourceRect : TRect; //source image (rect)
                                               target : TBitmap; targetRect : TRect);
var
  b : TBitmap;
begin

  //target = small piece of whole image
  //targetRect -> small piece of image in sourcerect

  //source = complete image
  //sourcerect = complete controls rects

  if FBuffered and FBufferValid then
    begin
      target.Canvas.Draw (0,0, FBitmap);
      exit;
    end;

  //get whole image
  target.Canvas.CopyRect (Rect (0, 0, sourceRect.Right - sourceRect.Left, sourceRect.Bottom-sourceRect.Top),
                          source.Canvas, sourceRect);

  //calculate effects for target rect only
  if FFLipVert then
    LMDBmpFlipVertical (target, targetRect, target, targetRect.TopLeft);
  if FFLipHoriz then
    LMDBmpFlipHorizontal (target, targetRect, target, targetRect.TopLeft);
  if FGrayScale then
    LMDBmpGrayScale (target, targetRect, target, targetRect.TopLeft);
  if FInvert then
    LMDBmpInvert (target, targetRect, target, targetRect.TopLeft);
  if FBrightness <> 0 then
    LMDBmpBrightness (target, targetRect, target, targetRect.TopLeft, FBrightness);

  //calculate Alpha blending
  if FAlphaObject.FillObject.Style <> sfNone then
    begin
      b := TBitmap.Create;
      try
        //sourceRect = aRect in TLMDCustomPanel.BackDrawArea, aRect = control's rect
        //we need a bitmpa with the same size as (+2 for left and right border)
        b.Width := sourceRect.Right - sourceRect.Left + 2;
        b.Height := sourceRect.Bottom - sourceRect.Top + 2;
        b.PixelFormat := pf24Bit;
        FAlphaObject.FillObject.FillCanvas (b.Canvas, b.Canvas.ClipRect, clWhite);
        b.PixelFormat := pf24Bit;

        LMDBMPAlphaBlend (target, b, targetRect, targetRect.TopLeft, target, FAlphaObject.Strength, targetRect.TopLeft);

      finally
        b.Free;
      end;
    end;
  if FBuffered and not FBufferValid then
    begin
      FBitmap.Width := target.Width;
      FBitmap.Height := target.Height;
      FBitmap.CAnvas.Draw (0, 0, target);
      FBufferValid := true;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectObject.DestroyBuffer;
begin
  FBufferValid := false;
end;

end.
