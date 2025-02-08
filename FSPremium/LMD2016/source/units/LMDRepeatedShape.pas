unit LMDRepeatedShape;
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

LMDRepeatedShape unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDBaseShape;

type
  TLMDRepeatedShape=class(TLMDBaseShape)
  private
    FShapeWidth,
    FShapeHeight,
    FHorOffset,
    FVerOffset,
    FHorCount,
    FVerCount: Integer;
    FSetPerCount: Boolean;
    procedure SetInteger(Index:integer; aValue: Integer);
    procedure SetSetPerCount(aValue: Boolean);
  protected
    function GetGradientRect:TRect; override;
    function GetPalette:HPalette; override;
    public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    published
    property CaptionClip;
    Property HorCount: integer index 4 read FHorCount write SetInteger default 5;
    Property HorOffset: integer index 2 read FHorOffset write SetInteger default 0;
    Property ShapeWidth: integer index 0 read FShapeWidth write SetInteger default 0;
    Property SetPerCount: boolean read FSetPerCount write SetSetPerCount default True;
    Property ShapeHeight: integer index 1 read FShapeHeight write SetInteger default 0;
    Property VerCount: integer index 5 read FVerCount write SetInteger default 5;
    Property VerOffset: integer index 3 read FVerOffset write SetInteger default 0;
  end;

implementation

uses
  Types, Graphics,
  LMDShape, LMDProcs, LMDGraphUtils, LMDGraph;

{------------------------- Private --------------------------------------------}
procedure TLMDRepeatedShape.SetInteger(Index:integer; aValue: Integer);
begin
  case index of
    0: if FShapeWidth=aValue then exit else FShapeWidth:=aValue;
    1: if FShapeHeight=aValue then exit else FShapeHeight:=aValue;
    2: if FHorOffset=aValue then exit else FHorOffset:=aValue;
    3: if FVerOffset=aValue then exit else FVerOffset:=aValue;
    4: if FHorCount=aValue then exit else FHorCount:=aValue;
    5: if FVerCount=aValue then exit else FVerCount:=aValue;
  end;
  GetChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDRepeatedShape.SetSetPerCount(aValue: Boolean);
begin
  if FSetPerCount<>aValue then
    begin
      FSetPerCount:=aValue;
      GetChange(self);
    end;
end;

{------------------------- Protected ------------------------------------------}
function TLMDRepeatedShape.GetGradientRect:TRect;
begin
  if FSetPerCount then
    begin
      FShapeWidth:=(Round((Width-(FHorCount-1)*FHorOffset)/FHorCount));
      FShapeHeight:=(Round((Height-(FVerCount-1)*FVerOffset)/FVerCount));
    end;
  result:=Rect(0,0,FShapeWidth,FShapeHeight);
end;

{------------------------------------------------------------------------------}
function TLMDRepeatedShape.GetPalette:HPalette;
begin
  result:=FShapeFill.Palette;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDRepeatedShape.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSetPerCount:=True;
  FShapeWidth:=0;
  FShapeHeight:=0;
  FHorOffset:=0;
  FVerOffset:=0;
  FHorCount:=5;
  FVerCount:=5;
  Mode:=scmShapeFill;
end;

{------------------------------------------------------------------------------}
destructor TLMDRepeatedShape.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDRepeatedShape.Paint;
var
  flags: word;
  i, j, maxX, maxY: integer;
  Temp: TBitmap;
  tempBrush: TBrush;
  aRect: TRect;
  ts:TLMDFillStyle;

begin
  if (csLoading in ComponentState) then exit;

  if FChange then
    begin
      GetShapeChange;
      FChange:=False;
    end;

  if FCacheBitmap.Empty then OffscreenPaint;

  flags:=0;ts:=sfNone;
  tempBrush:=nil;

  if not Transparent then FillControl;

  if FSetPerCount then
    begin
      FShapeWidth:=(Trunc((Width-(FHorCount-1)*FHorOffset)/FHorCount));
      FShapeHeight:=(Trunc((Height-(FVerCount-1)*FVerOffset)/FVerCount));
      maxX:=FHorCount;
      maxY:=FVerCount;
    end
  else
    begin
      maxX:=(Width div FShapeWidth);
      maxY:=(Height div FShapeHeight);
      if not Transparent then
        begin
          inc(maxX);
          inc(maxY)
        end;
    end;

  Temp:=TBitmap.Create;
  try
    if Transparent then
      begin
        Temp.Width:=FShapeWidth+FHorOffset;
        Temp.Height:=FShapeHeight+FVerOffset;
      end
    else
      begin
        Temp.Width:=FShapeWidth;
        Temp.Height:=FShapeHeight;
      end;

    with Temp.Canvas do
      begin
        Brush.Color:=Color;
        Brush.Style:=bsSolid;
        FillRect(Rect(0,0,Width,Height));
      end;

    if (ts in [sfBitmapList, sfBitmap]) and (FShapeFill.CurrentBitmap=nil) then
      ts:=sfNone
    else
      ts:=FShapeFill.Style;

    case ts of
      sfGradient:
        begin
          LMDShapeDraw(Rect(0,0,FShapeWidth,FShapeHeight),Temp.Canvas,Shape,nil,
           nil,Square,Brush,RoundPercent,Bevel,Shadow,FCacheBitmap,Color,BrushBackColor,flags);
          FShapeFill.Gradient.SetRealPalette(Canvas);
        end;
      sfBitmap, sfBitmapList:
        LMDShapeDraw(Rect(0,0,FShapeWidth,FShapeHeight),Temp.Canvas,Shape,nil,
        nil,Square,Brush,RoundPercent,Bevel,Shadow,FCacheBitmap,Color,BrushBackColor,flags);
      sfBrush:
        LMDShapeDraw(Rect(0,0,FShapeWidth,FShapeHeight),Temp.Canvas,Shape,nil,
         nil,Square,Brush,RoundPercent,Bevel,Shadow,nil,Color,BrushBackColor,flags);
      sfNone,sfBrushBitmap:
        begin
          {if not Transparent then FillControl;}
          try
            tempBrush:=TBrush.Create;
            case FShapeFill.Style of
              sfBrushBitmap: tempBrush.Bitmap:=FShapeFill.Bitmap;
              sfNone:        tempBrush.Style:=bsClear;
            end;
            {ClientRect,Canvas}
            LMDShapeDraw(Rect(0,0,FShapeWidth,FShapeHeight),Temp.Canvas,Shape,nil,
            nil,Square,tempBrush,RoundPercent,Bevel,Shadow,nil,Color,BrushBackColor,0);
          finally
            tempBrush.Free;
          end;
        end;

    end;{case}

    if Transparent then
    begin
      if FSetPerCount then
        LMDBmpDraw(Canvas,Rect(0,0,(maxX-2)*(FShapeWidth),
         (maxY-2)*(FShapeHeight)),Temp,DSF_TRANSPARENCY or DSF_TILE,Color)
      else
        LMDBmpDraw(Canvas,ClientRect,Temp,DSF_TRANSPARENCY or DSF_TILE,Color)
    end
    else
    begin
      for i := 0 to maxY - 1 do
        for j := 0 to maxX - 1 do
          Canvas.Draw((FShapeWidth+FHorOffset)*j,(FShapeHeight+FVerOffset)*i,Temp)
    end;
  finally
    if Temp<>nil then Temp.Destroy;
  end;

  {now draw the Caption}
  if not CaptionClip then DrawCaption(Canvas, aRect);
end;

end.
