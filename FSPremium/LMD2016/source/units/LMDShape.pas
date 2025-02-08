unit LMDShape;
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

LMDShape unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Graphics,
  LMDTypes, LMDGraph, LMDSimpleBevel, LMDShadow, LMDObject, LMDPointList, LMDTeeth;

  // Moved from LMDGrapA   {for shapes}

type
  PPoints = ^TPoints;
  TPoints = array [0..110] of TPoint;

  TLMDShapeType=(stEllipse,stRectangle,stRoundRect,stDirectUp,stDirectRight,
                 stDirectDown,stDirectLeft,stDiamond,stComb,stOctagon,stStar);

  TLMDShape = class(TLMDObject)
    private
      FBevel: TLMDSimpleBevel;
      FBrush: TBrush;
      FRoundPercent: TLMDPercent;
      FShadow: TLMDShadow;
      FShape: TLMDShapeType;
      FSquare: Boolean;

      procedure SetBevel(aValue: TLMDSimpleBevel);
      procedure SetBrush(aValue: TBrush);
      procedure SetRoundPercent(aValue: TLMDPercent);
      procedure SetShadow(aValue: TLMDShadow);
      procedure SetShape(aValue: TLMDShapeType);
      procedure SetSquare(aValue: Boolean);
    public
      constructor Create(Owner:TPersistent=nil);override;
      destructor Destroy;override;
    published
      property Bevel: TLMDSimpleBevel read FBevel write SetBevel;
      property Brush: TBrush read FBrush write SetBrush;
      property RoundPercent: TLMDPercent read FRoundPercent write SetRoundPercent default 33;
      property Shadow: TLMDShadow read FShadow write SetShadow;
      property Shape: TLMDShapeType read FShape write SetShape default stRectangle;
      property Square: Boolean read FSquare write SetSquare default False;
  end;

 procedure LMDShapeCalc(aRect: TRect;aShape: TLMDShapeType; aTeeth: TLMDTeeth;
                       Square:Boolean; aBrush:TBrush; aRoundPercent: TLMDPercent;
                       aBevel: TLMDSimpleBevel; aShadow: TLMDShadow;
                       aList: TLMDPointList);

  procedure LMDShapeDraw(aRect: TRect; aCanvas:TCanvas;
                         aShape: TLMDShapeType; aTeeth: TLMDTeeth;
                         aList: TLMDPointList; Square:Boolean;
                         aBrush:TBrush; aRoundPercent: TLMDPercent;
                         aBevel: TLMDSimpleBevel; aShadow: TLMDShadow;
                         aBitmap: TBitmap; TransCol,BrushBackCol: TColor;
                         flags: word);
  procedure LMDOffsetPointArray(var anArray: array of TPoint; Count,Offsx,Offsy: integer);
  procedure LMDOffsetPointList(aList: TLMDPointList; Offsx,Offsy: integer);

implementation

uses
  Types,
  {$IFDEF LMDCOMP16}System.UITypes,{$endif}
  LMDGraphUtils, LMDClass, LMDProcs;
  {------------------------- Private --------------------------------------------}
procedure TLMDShape.SetBevel(aValue: TLMDSimpleBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShape.SetBrush(aValue: TBrush);
begin
  FBrush.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShape.SetRoundPercent(aValue: TLMDPercent);
begin
  if FRoundPercent<>aValue then
    begin
      FRoundPercent:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShape.SetShadow(aValue: TLMDShadow);
begin
  FShadow.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShape.SetShape(aValue: TLMDShapeType);
begin
  if aValue<>FShape then
    begin
      FShape:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShape.SetSquare(aValue: Boolean);
begin
  if aValue<>FSquare then
    begin
      FSquare:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDShape.Create;
begin
  inherited Create;
  FRoundPercent:=33;
  FShape:=stRectangle;
  FSquare:=False;
  FShadow:=TLMDShadow.Create;
  FShadow.OnChange:=GetChange;
  FBevel:=TLMDSimpleBevel.Create;
  FBevel.OnChange:=GetChange;
  FBrush:=TBrush.Create;
  FBrush.OnChange:=GetChange;
 end;

{------------------------------------------------------------------------------}
destructor TLMDShape.Destroy;
begin
  FBevel.OnChange:=nil;
  FBrush.OnChange:=nil;
  FShadow.OnChange:=nil;
  FBevel.Free;
  FBrush.Free;
  FShadow.Free;
  inherited Destroy;
end;

{*****************************+ LMDShapeCalc **********************************}
{------------------------------------------------------------------------------}
procedure LMDShapeCalc(aRect: TRect;aShape: TLMDShapeType; aTeeth: TLMDTeeth;
                       Square:Boolean; aBrush:TBrush; aRoundPercent: TLMDPercent;
                       aBevel: TLMDSimpleBevel; aShadow: TLMDShadow;
                       aList: TLMDPointList);
var
  aShadowDepth: integer;
  RoundValue,bo,bo2,flip,i,upto: integer;
  Width,Height,xOffs,yOffs,GonX,GonY,BevelWidth: integer;
  PR: TRect;
  WasNil:Boolean;
begin
  aList.Clear;
  upto:=0;

  if aShadow=nil then
    begin
      aShadow:=TLMDShadow.Create;
      aShadow.Depth:=0;
      WasNil:=True;
    end
  else
    WasNil:=False;

  if aShadow.Style=hssNone then
    aShadowDepth:=0
  else
    aShadowDepth:=aShadow.Depth;

  try
    if (aTeeth<>nil) or (aBevel = nil) then
      BevelWidth:=1
    else
      BevelWidth:=aBevel.Width;

    bo:=((BevelWidth)) div 2;
    bo2:=((BevelWidth-1)) div 2 ;
    Width:=aRect.Right-aRect.Left;
    Height:=aRect.Bottom-aRect.Top;

     if Square then
       begin
         if Width>Height then
           begin
             xOffs:=(Width-Height) div 2;
             yOffs:=0;
           end
         else
           begin
             xOffs:=0;
             yOffs:=(Height-Width) div 2;
           end;
         PR:=Rect(aShadowDepth+xOffs,aShadowDepth+yOffs,Width-xOffs,Height-yOffs);
       end
     else
       PR:=Rect(aShadowDepth,aShadowDepth,Width,Height);

     RoundValue:=integer((aRoundPercent*LMDMin([Width-aShadowDepth,Height-aShadowDepth])) div 100);

     GonX:=0;
     GonY:=0;
     case aShape of
       stComb:
         begin
           GonY:=Round((PR.Bottom-Pr.Top)/5);
         end;
       stOctagon:
         begin
           GonX:=Round((PR.Right-Pr.Left) / (2+SQRT(2)));
           GonY:=Round((PR.Bottom-Pr.Top) / (2+SQRT(2)));
         end;
     end;

    {---------------------------------------------------------------}

    with aList do
      if aTeeth=nil then
        case aShape of
          stRectangle:
            begin
              AddPoint(PR.Left,PR.Top);
              AddPoint(PR.Right,PR.Bottom);
              AddPoint(Points[0].x+bo,Points[0].y+bo);
              AddPoint(Points[1].x-bo2,Points[1].y-bo2);
            end;
          stRoundRect:
            begin
              AddPoint(PR.Left,PR.Top);
              AddPoint(PR.Right,PR.Bottom);
              AddPoint(RoundValue,RoundValue);
              AddPoint(Points[0].x+bo,Points[0].y+bo);
              AddPoint(Points[1].x,Points[1].y);
              AddPoint(Points[2].x+aShadowDepth,Points[2].y+aShadowDepth);
            end;
          stEllipse:
            begin
              AddPoint(PR.Left,PR.Top);
              AddPoint(PR.Right,PR.Bottom);
              AddPoint(Points[0].x+bo,Points[0].y+bo);
              AddPoint(Points[1].x-bo2,Points[1].y-bo2);
            end;
          stDirectUp:
            begin
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Top);
              AddPoint(PR.Right,PR.Bottom);
              AddPoint(PR.Left,PR.Bottom);
              AddPoint(Points[0].x,Points[0].y+bo);
              AddPoint(Points[1].x-bo2,Points[1].y-bo2);
              AddPoint(Points[2].x+2*bo,Points[2].y);
            end;
          stDirectRight:
            begin
              AddPoint(PR.Left,PR.Top);
              AddPoint(PR.Right,PR.Top+(PR.Bottom-Pr.Top)div 2);
              AddPoint(PR.Left,PR.Bottom);
              AddPoint(Points[0].x+bo,Points[0].y+bo);
              AddPoint(Points[1].x-bo2,Points[1].y);
              AddPoint(Points[2].x+bo,Points[2].y-bo2);
            end;
          stDirectDown:
            begin
              AddPoint(PR.Left,PR.Top);
              AddPoint(PR.Right,PR.Top);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Bottom);
              AddPoint(Points[0].x+bo,Points[0].y+bo);
              AddPoint(Points[1].x-bo2,Points[1].y+bo);
              AddPoint(Points[2].x,Points[2].y);
            end;
          stDirectLeft:
            begin
              AddPoint(PR.Right,PR.Top);
              AddPoint(PR.Left,PR.Top+(PR.Bottom-Pr.Top)div 2);
              AddPoint(PR.Right,PR.Bottom);
              AddPoint(Points[0].x-bo2,Points[0].y+bo);
              AddPoint(Points[1].x+bo,Points[1].y);
              AddPoint(Points[2].x-bo2,Points[2].y-bo2);
            end;
          stDiamond:
            begin
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Top);
              AddPoint(PR.Right,PR.Top+(PR.Bottom-Pr.Top)div 2);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Bottom);
              AddPoint(Pr.Left,PR.Top+(PR.Bottom-Pr.Top)div 2);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Top+bo);
              AddPoint(PR.Right-bo2,PR.Top+(PR.Bottom-Pr.Top)div 2);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Bottom-bo2);
              AddPoint(Pr.Left+bo,PR.Top+(PR.Bottom-Pr.Top)div 2);
            end;
          stComb:
            begin
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Top);
              AddPoint(PR.Right,PR.Top+GonY);
              AddPoint(PR.Right,PR.Top+GonY+GonY*3);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Bottom);
              AddPoint(Pr.Left,PR.Top+GonY+GonY*3);
              AddPoint(Pr.Left,PR.Top+GonY);

              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Top+bo);
              AddPoint(PR.Right-bo2,PR.Top+GonY+bo);
              AddPoint(PR.Right-bo2,PR.Top+GonY+GonY*3+bo);
              AddPoint(PR.Left+(PR.Right-Pr.Left)div 2,PR.Bottom-bo2);
              AddPoint(Pr.Left+bo,PR.Top+GonY+GonY*3+bo);
              AddPoint(Pr.Left+bo,PR.Top+GonY+bo);
            end;
          stOctagon:
            begin
              AddPoint(PR.Left+GonX,PR.Top);
              AddPoint(PR.Left+GonX+Round(GonX*SQRT(2)),PR.Top);
              AddPoint(PR.Right,PR.Top+GonY);
              AddPoint(PR.Right,PR.Top+GonY+Round(GonY*SQRT(2)));
              AddPoint(PR.Left+GonX+Round(GonX*SQRT(2)),PR.Bottom);
              AddPoint(PR.Left+GonX,PR.Bottom);
              AddPoint(Pr.Left,PR.Top+GonY+Round(GonY*SQRT(2)));
              AddPoint(Pr.Left,PR.Top+GonY);

              AddPoint(PR.Left+GonX+bo,PR.Top+bo);
              AddPoint(PR.Left+GonX+Round(GonX*SQRT(2))+bo,PR.Top+bo);
              AddPoint(PR.Right-bo2,PR.Top+GonY+bo);
              AddPoint(PR.Right-bo2,PR.Top+GonY+Round(GonY*SQRT(2))+bo);
              AddPoint(PR.Left+GonX+Round(GonX*SQRT(2))+bo,PR.Bottom-bo2);
              AddPoint(PR.Left+GonX+bo,PR.Bottom-bo2);
              AddPoint(Pr.Left+bo,PR.Top+GonY+Round(GonY*SQRT(2))+bo);
              AddPoint(Pr.Left+bo,PR.Top+GonY+bo);
            end;
          stStar:
            begin
              AddPoint(PR.Left+(PR.Right-PR.Left)div 2,PR.Top);
              AddPoint(PR.Left+Round(0.65*(PR.Right-PR.Left)),PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Right,PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.7*(PR.Right-PR.Left)),PR.Top+Round(0.6*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.85*(PR.Right-PR.Left)),PR.Bottom);
              AddPoint(PR.Left+(PR.Right-PR.Left)div 2,PR.Top+Round(0.75*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.15*(PR.Right-PR.Left)),PR.Bottom);
              AddPoint(PR.Left+Round(0.3*(PR.Right-PR.Left)),PR.Top+Round(0.6*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left,PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.35*(PR.Right-PR.Left)),PR.Top+Round(0.38*(PR.Bottom-PR.Top)));

              AddPoint(PR.Left+(PR.Right-PR.Left)div 2,PR.Top+bo);
              AddPoint(PR.Left+Round(0.65*(PR.Right-PR.Left)),PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Right-bo2,PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.7*(PR.Right-PR.Left)),PR.Top+Round(0.6*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.85*(PR.Right-PR.Left)),PR.Bottom-bo2);
              AddPoint(PR.Left+(PR.Right-PR.Left)div 2,PR.Top+Round(0.75*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.15*(PR.Right-PR.Left)),PR.Bottom-bo2);
              AddPoint(PR.Left+Round(0.3*(PR.Right-PR.Left)),PR.Top+Round(0.6*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+bo2,PR.Top+Round(0.38*(PR.Bottom-PR.Top)));
              AddPoint(PR.Left+Round(0.35*(PR.Right-PR.Left)),PR.Top+Round(0.38*(PR.Bottom-PR.Top)));

            end;
        end{ case aShape of }
      else                      {read Teeth-object}
        begin
          aTeeth.BeginUpdate;

          case aTeeth.Direction of
            tdUp,tdDown:
              if aTeeth.SetPerCount then
                begin
                  upto:=aTeeth.Count*2;
                  aTeeth.Width:=Round((PR.Right-PR.Left)/(upto));
                end
              else
                upto:=Round((PR.Right-PR.Left)/aTeeth.Width)*2;
            tdRight,tdLeft:
              if aTeeth.SetPerCount then
                begin
                  upto:=aTeeth.Count*2;
                  aTeeth.Height:=Round((PR.Bottom-PR.Top)/(upto));
                end
              else
                upto:=Round((PR.Bottom-PR.Top)/aTeeth.Height)*2;
          end;

          if aTeeth.Offset then flip:=0 else flip:=1;
          case aTeeth.Direction of
            tdRight:
              begin
                AddPoint(PR.Right-flip*aTeeth.Width-1,PR.Bottom-1);
                AddPoint(PR.Left,PR.Bottom-1);
                AddPoint(PR.Left,PR.Top);
                AddPoint(PR.Right-flip*aTeeth.Width-1,PR.Top);
              end;
            tdLeft:
              begin
                AddPoint(PR.Left+flip*aTeeth.Width,PR.Bottom-1);
                AddPoint(PR.Right-1,PR.Bottom-1);
                AddPoint(PR.Right-1,PR.Top);
                AddPoint(PR.Left+flip*aTeeth.Width,PR.Top);
              end;
            tdUp:
              begin
                AddPoint(PR.Right-1,PR.Top+flip*aTeeth.Height);
                AddPoint(PR.Right-1,PR.Bottom-1);
                AddPoint(PR.Left,PR.Bottom-1);
                AddPoint(PR.Left,PR.Top+flip*aTeeth.Height);
              end;
            tdDown:
              begin
                AddPoint(PR.Right-1,PR.Bottom-flip*aTeeth.Height);
                AddPoint(PR.Right-1,PR.Top);
                AddPoint(PR.Left,PR.Top);
                AddPoint(PR.Left,PR.Bottom-flip*aTeeth.Height);
              end;
          end;

          for i:=0 to upto do
            begin
              if aTeeth.Offset then flip:=(i mod 2) else flip:=((i+1) mod 2);
              case aTeeth.Direction of
                tdRight:
                  AddPoint(PR.Right-flip*aTeeth.Width-1,
                           LMDMin([PR.Top+aTeeth.Height*i,PR.Bottom]));
                tdLeft:
                  AddPoint(PR.Left+flip*aTeeth.Width,
                           LMDMin([PR.Top+aTeeth.Height*i,PR.Bottom]));
                tdUp:
                  AddPoint(LMDMin([PR.Left+aTeeth.Width*i,PR.Right]),
                                 PR.Top+flip*aTeeth.Height);
                tdDown:
                  AddPoint(LMDMin([PR.Left+aTeeth.Width*i,PR.Right]),
                                 PR.Bottom-flip*aTeeth.Height);
              end;
            end;

            {the last tooth shouldn't get out of the borders
             (this would happen because of inprecision on rounding)}

            if aTeeth.Offset then flip:=(upto mod 2) else flip:=((upto+1) mod 2);
            case aTeeth.Direction of
              tdRight:
                AddPoint(PR.Right-flip*aTeeth.Width-1,PR.Bottom);
              tdLeft:
                AddPoint(PR.Left+flip*aTeeth.Width,PR.Bottom);
              tdUp:
                AddPoint(PR.Right,PR.Top+flip*aTeeth.Height);
              tdDown:
                AddPoint(PR.Right,PR.Bottom-flip*aTeeth.Height);
            end;

          aTeeth.EndUpdate(False);
        end;

  finally
    if WasNil then
      aShadow.Free;
  end;

end;

{------------------------------------------------------------------------------}

procedure LMDShapeDraw(aRect: TRect; aCanvas:TCanvas;
                       aShape: TLMDShapeType; aTeeth: TLMDTeeth;
                       aList: TLMDPointList; Square:Boolean;
                       aBrush:TBrush; aRoundPercent: TLMDPercent;
                       aBevel: TLMDSimpleBevel; aShadow: TLMDShadow;
                       aBitmap: TBitmap; TransCol,BrushBackCol: TColor;
                       flags: word);
var
  aShadowDepth: integer;
  pp: array of TPoint;
  aSpecCanvas: TCanvas;
  aMask, aMask3:TBitmap;
  LCol, SCol: TColor;
  DrawCycle,RoundValue,R,bo,bo2, Width, Height, i, BevelWidth: Integer;
  WasNil: array [0..1] of Boolean;
begin
  {Set default values to calm down the 32bit compiler}
  LCol:=0;
  SCol:=0;
  pp:=nil;

  TransCol:=ColorToRGB(TransCol);

  aMask:=TBitmap.Create;

  if (aTeeth<>nil) or (aBevel = nil) then
    BevelWidth:=1
  else
    BevelWidth:=aBevel.Width;

  {Calculate a BorderOffset because of PenWidth}
  bo:=((BevelWidth)) div 2;
  bo2:=((BevelWidth-1)) div 2 ;
  Width:=aRect.Right-aRect.Left;
  Height:=aRect.Bottom-aRect.Top;

  if aShadow=nil then
    begin
      aShadow:=TLMDShadow.Create;
      aShadow.Depth:=0;
      WasNil[0]:=True;
    end
  else
    WasNil[0]:=False;

  if aShadow.Style=hssNone then
    aShadowDepth:=0
  else
    aShadowDepth:=aShadow.Depth;

  if aList=nil then
    begin
      aList:=TLMDPointList.Create;
      LMDShapeCalc(aRect,aShape,aTeeth,Square,aBrush,aRoundPercent,aBevel,aShadow,
                   aList);
      WasNil[1]:=True;
    end
  else
    WasNil[1]:=False;

  if aTeeth<>nil then
    begin
      SetLength(pp, aList.Count);
      for i:=0 to aList.Count-1 do
        pp[i] := aList.Points[i];
    end;

  LMDOffsetPointList(aList,aRect.Left,aRect.Top);

  try
    RoundValue:=integer((aRoundPercent*LMDMin([Width-aShadowDepth,Height-aShadowDepth])) div 100);
    R:=RoundValue div 2;

    if (aShadowDepth<>0) and (aShadow.Style<>hssNone) then
      with aCanvas do
        begin
          { Schatten zeichnen --------------------------------------------------------------------------------------------}
          Pen.Style:=psClear;
          if aShadow.Style=hssTracing then
            begin
              Brush.Bitmap:=LMDApplication.GetBrushBitmap(aShadow.Color);
              Pen.Mode:=pmMask;
              Pen.Style:=psClear;
            end
          else
            begin
              Brush.Style:=bsSolid;
              Brush.Color:=aShadow.Color;
            end;

          with aList do
            if aTeeth=nil then
              case aShape of
                stRectangle:
                  Rectangle(Points[0].x,Points[0].y,
                            Points[1].x,Points[1].y);
                stRoundRect:
                  RoundRect(Points[0].x,Points[0].y,
                            Points[1].x,Points[1].y,
                            Points[2].x,Points[2].y);
                stEllipse:
                  Ellipse(Points[0].x,Points[0].y,
                          Points[1].x,Points[1].y);
                stDirectUp,stDirectRight,stDirectDown,stDirectLeft:
                  Polygon([Points[0],Points[1],
                           Points[2]]);
                stDiamond:
                  Polygon([Points[0],Points[1],
                           Points[2],Points[3]]);
                stComb:
                  Polygon([Points[0],Points[1],
                           Points[2],Points[3],
                           Points[4],Points[5]]);
                stOctagon:
                  Polygon([Points[0],Points[1],
                           Points[2],Points[3],
                           Points[4],Points[5],
                           Points[6],Points[7]]);
                stStar:
                  Polygon([Points[0],Points[1],Points[2],Points[3],Points[4],
                          Points[5],Points[6],Points[7],Points[8],Points[9]]);
              end{ case aShape of }
            else
              Polygon(pp);  // RM: Using VCL method instead
        end; {with aCanvas do}

    { Brush zeichnen --------------------------------------------------------------------------------------------}
    LMDOffsetPointList(aList,-aShadowDepth,-aShadowDepth);
    if aTeeth<>nil then
      LMDOffsetPointArray(pp, aList.Count,-aShadowDepth,-aShadowDepth);

    //aBevel = nil is not allowed ....
    for DrawCycle:=0 to 1 do
      begin
        if (DrawCycle=1) or (not ((BevelWidth=0) or (aBevel.Style<>sbNormal) or (aBitmap<>nil))) then
          with aCanvas do
            begin
              Pen.Mode:=pmCopy;
              if aBevel.Width=0 then
                Pen.Style:=psClear
              else
                begin
                  Pen.Style:=psSolid;
                  Pen.Width:=BevelWidth;
                  Pen.Color:=aBevel.Color;
                end;
            end;

        {if drawing a gradient or a bitmap use a MaskBmp and normal Pen/Brush}
        if (aBitmap<>nil) and (DrawCycle=0) then
          begin
            aMask.Width:=Width;
            aMask.Height:=Height;
            aMask.PixelFormat:=pf24Bit;  // workarounds error with ATI drivers in 32bit mode
            with aMask.Canvas do
              begin
                Pen.Mode:=pmCopy;
                if aBevel.Width=0 then
                  Pen.Style:=psClear
                else
                  begin
                    Pen.Style:=psSolid;
                    Pen.Width:=BevelWidth;
                    Pen.Color:=clWhite;
                  end;
                Brush.Color:=TransCol;
                Brush.Style:=bsSolid;
                FillRect(Rect(0,0,Width,Height));
                Brush.Color:=clWhite;
              end;
            aSpecCanvas:=aMask.Canvas;
          end
        else
          begin
            with aCanvas do
              begin
                Pen.Mode:=pmCopy;
                if aBevel.Width=0 then Pen.Style:=psClear else Pen.Width:=BevelWidth;

                if aBevel.Style<>sbNormal then Pen.Color:=Brush.Color;
                if (aBitmap=nil) then Brush:=aBrush else Brush.Style:=bsClear;

                if (DrawCycle=1) and (Brush.Style<>bsSolid) then
                  begin
                    SetBKColor(Handle,ColorToRGB(BrushBackCol));
                    SetBKMode(Handle,Opaque);
                  end;
              end;
            aSpecCanvas:=aCanvas;
          end;

        {now drawing wether on aCanvas or the MonoBmp (for gradient and bitmapping}
        with aSpecCanvas do
          begin
            with aList do
              if aTeeth=nil then
                case aShape of
                  stRectangle:
                    Rectangle(Points[2].x,Points[2].y,
                              Points[3].x,Points[3].y);
                  stRoundRect:
                    RoundRect(Points[3].x,Points[3].y,
                              Points[4].x,Points[4].y,
                              Points[5].x,Points[5].y);
                  stEllipse:
                    Ellipse(Points[2].x,Points[2].y,
                            Points[3].x,Points[3].y);
                  stDirectUp,stDirectRight,stDirectDown,stDirectLeft:
                    Polygon([Points[3],Points[4],Points[5]]);
                  stDiamond:
                    Polygon([Points[4],Points[5],Points[6],Points[7]]);
                  stComb:
                    Polygon([Points[6],Points[7],Points[8],
                            Points[9],Points[10],Points[11]]);
                  stOctagon:
                  {  8   9
                   15     10
                   14     11
                     13 12 }
                    Polygon([Points[8],Points[9],Points[10],Points[11],
                             Points[12],Points[13],Points[14],Points[15]]);
                  stStar:
                    Polygon([Points[10],Points[11],Points[12],Points[13],Points[14],
                             Points[15],Points[16],Points[17],Points[18],Points[19]])
                end{ case aShape of }
              else
                //Windows.Polygon(Handle, pp, Count);
                Polygon(pp);
                end;{with aSpecCanvas do begin}

     {Bitmap zeichnen --------------------------------------------------------------------------------------------}
     if (aBitmap<>nil) and (DrawCycle=0) then
       begin
         aMask3:=TBitmap.Create;
         try
           aMask3.assign(aBitmap);
           LMDMaskBmpDraw(aCanvas,Rect(0,0,Width,Height),aMask,aMask3,clWhite,TransCol);
         finally
           aMask3.Free;
         end;
       end;

   end;{for DrawCycle:=0 to 1}

   if BevelWidth=0 then exit;
   { 3D Bevel zeichnen --------------------------------------------------------------------------------------------}

    with aCanvas do
      begin

        Pen.Mode:=pmCopy;
        Pen.Style:=psSolid;
        Pen.Width:=BevelWidth;

        case aBevel.Style of
          sbNormal: exit;
          sbInset:
            begin
              LCol:=aBevel.ShadowColor;
              SCol:=aBevel.LightColor;
            end;
          sbOffset:
            begin
              LCol:=aBevel.LightColor;
              SCol:=aBevel.ShadowColor;
            end;
        end;

        Pen.Color:=LCol;

        with aList do
          case aShape of
            stRectangle:
              begin
                PolyLine([Point(Points[0].x+bo,Points[1].y-bo2),
                          Point(Points[0].x+bo,Points[0].y+bo),
                          Point(Points[1].x-bo2,Points[0].y+bo)]);
                Pen.Color:=SCol;
                PolyLine([Point(Points[1].x-bo2-1,Points[0].y+bo),
                          Point(Points[1].x-bo2-1,Points[1].y-bo2-1),
                          Point(Points[0].x+bo,Points[1].y-bo2-1)]);
              end;
            stRoundRect:
              begin
                {upper-left}
                Arc(Points[0].x+bo,Points[0].y+bo,Points[0].x+bo+RoundValue,
                    Points[0].y+bo+RoundValue,{|}Points[0].x+bo+R,Points[0].y+bo,
                    Points[0].x+bo,Points[0].y+bo+R);
                {upper-right}
                Arc(Points[1].x-bo2-RoundValue,Points[0].y+bo,
                    Points[1].x-bo2,Points[0].y+bo+RoundValue,Points[1].x-bo2,
                    Points[0].y+bo,Points[1].x-bo2-R,Points[0].y+bo);
                {lower-left}
                Arc(Points[0].x+bo,Points[1].y-bo2-RoundValue,Points[0].x+bo+RoundValue,
                    Points[1].y-bo2,Points[0].x+bo,Points[1].y-bo2-R,Points[0].x+bo,
                    Points[1].y-bo2);
                PolyLine([Point(Points[0].x+bo,Points[0].y+bo+R),
                          Point(Points[0].x+bo,Points[1].y-bo2-R)]);
                PolyLine([Point(Points[0].x+bo+R,Points[0].y+bo),
                          Point(Points[1].x-bo2-R,Points[0].y+bo)]);
                Pen.Color:=SCol;
                {upper-right}
                Arc(Points[1].x-bo2-RoundValue,Points[0].y+bo,Points[1].x-bo2,
                    Points[0].y+bo+RoundValue,Points[1].x-bo2,Points[0].y+bo+R,
                    Points[1].x-bo2,Points[0].y+bo);
                {lower-right}
                Arc(Points[1].x-bo2-RoundValue,Points[1].y-bo2-RoundValue,
                    Points[1].x-bo2,Points[1].y-bo2,Points[1].x-bo2-R,
                    Points[1].y-bo2,Points[1].x-bo2,Points[1].y-bo2-R);
                {lower-left}
                Arc(Points[0].x+bo,Points[1].y-bo2-RoundValue,Points[0].x+bo+RoundValue,
                Points[1].y-bo2,Points[0].x+bo,Points[1].y-bo2,Points[0].x+bo+R,
                Points[1].y-bo2);
                PolyLine([Point(Points[1].x-bo2-1,Points[0].y+bo+R),
                          Point(Points[1].x-bo2-1,Points[1].y-bo2-R)]);
                PolyLine([Point(Points[0].x+bo+R,Points[1].y-bo2-1),
                          Point(Points[1].x-bo2-R,Points[1].y-bo2-1)]);
              end;
            stEllipse:
              begin
                Arc(Points[0].x+bo,Points[0].y+bo,Points[1].x-bo2,Points[1].y-bo2,
                 Points[1].x-bo2,Points[0].y+bo,Points[0].x+bo,Points[1].y-bo2);
                Pen.Color:=SCol;
                 Arc(Points[0].x+bo,Points[0].y+bo,Points[1].x-bo2,Points[1].y-bo2,
                  Points[0].x+bo,Points[1].y-bo2,Points[1].x-bo2,Points[0].y+bo);
              end;
            stDirectUp:
              begin
                PolyLine([Points[2],Points[0],Points[1]]);
                Pen.Color:=SCol;
                PolyLine([Points[1],Points[2]]);
              end;
            stDirectRight:
              begin
                PolyLine([Point(Points[0].x+bo,Points[0].y+bo),
                          Point(Points[2].x+bo,Points[2].y-bo2)]);
                Pen.Color:=SCol;
                PolyLine([Point(Points[0].x+bo,Points[0].y+bo),
                          Point(Points[1].x-bo2,Points[1].y),
                          Point(Points[2].x+bo,Points[2].y-bo2)]);
              end;
            stDirectDown:
              begin
                Pen.Color:=SCol; {Paint using SCol first!}
                PolyLine([Point(Points[0].x-bo2,Points[0].y+bo),
                          Point(Points[2].x,Points[2].y-bo2),
                          Point(Points[1].x-bo2,Points[1].y+bo)]);
                Pen.Color:=LCol;
                PolyLine([Point(Points[0].x+bo,Points[0].y+bo),
                         Point(Points[1].x-bo2,Points[1].y-bo2)]);
              end;
            stDirectLeft:
              begin
                Pen.Color:=SCol; {Paint using SCol first!}
                PolyLine([Point(Points[0].x-bo-1,Points[0].y+bo),
                         Point(Points[2].x-bo-1,Points[2].y-bo2)]);
                Pen.Color:=LCol;
                PolyLine([Point(Points[0].x-bo-1,Points[0].y+bo),
                          Point(Points[1].x+bo,Points[1].y+bo),
                          Point(Points[2].x-bo-1,Points[2].y-bo)]);
              end;
            stDiamond:
              begin
                PolyLine([Point(Points[3].x+bo,Points[3].y),
                          Point(Points[0].x,Points[0].y+bo),
                          Point(Points[1].x-bo2,Points[1].y)]);
                Pen.Color:=SCol;
                PolyLine([Point(Points[1].x-bo2,Points[1].y),
                          Point(Points[2].x,Points[2].y-bo2),
                          Point(Points[3].x+bo,Points[3].y)]);
              end;
            stComb:
              begin
                PolyLine([Point(Points[4].x+bo,Points[4].y){lower-left},
                          Point(Points[5].x+bo,Points[5].y){upper-left},
                          Point(Points[0].x,Points[0].y+bo){upper-mid},
                          Point(Points[1].x-bo2-1,Points[1].y){upper-right}]);
                Pen.Color:=SCol;
                PolyLine([Point(Points[1].x-bo2-1,Points[1].y){upper-right},
                          Point(Points[2].x-bo2-1,Points[2].y){lower-right},
                          Point(Points[3].x,Points[3].y-bo2){lower-mid},
                          Point(Points[4].x+bo,Points[4].y){lower-left}]);
              end;
            stOctagon:
            {  1  2
             8      3
             7      4
               6  5 }
              begin
                PolyLine([Point(Points[6].x+bo,Points[6].y){1},
                         Point(Points[7].x+bo,Points[7].y){2},
                         Point(Points[0].x,Points[0].y+bo){3},
                         Point(Points[1].x,Points[1].y+bo){4},
                         Point(Points[2].x-bo2-1,Points[2].y){5}]);
                Pen.Color:=SCol;
                PolyLine([Point(Points[2].x-bo2-1,Points[2].y){5},
                         Point(Points[3].x-bo2-1,Points[3].y){6},
                         Point(Points[4].x,Points[4].y-bo2){7},
                         Point(Points[5].x,Points[5].y-bo2){8},
                         Point(Points[6].x+bo,Points[6].y){1}]);

              end;
            stStar:
              begin
                PolyLine([Points[1],Points[2]]);
                PolyLine([Points[3],Points[4]]);
                PolyLine([Points[8],Points[9],Points[0]]);
                PolyLine([Points[6],Points[7]]);
                Pen.Color:=SCol;
                PolyLine([Points[0],Points[1]]);
                PolyLine([Points[2],Points[3]]);
                PolyLine([Points[4],Points[5],Points[6]]);
                PolyLine([Points[7],Points[8]]);
              end
          else
            ;
          end;{case aShape of}

    end;{ with aCanvas do }

  finally
    aMask.Free;
    if WasNil[1] then
      aList.Free
    else
      LMDOffsetPointList(aList,aShadowDepth-aRect.Left,aShadowDepth-aRect.Top);

    if WasNil[0] then
      aShadow.Free;
  end;

end;

{------------------------------------------------------------------------------}
procedure LMDOffsetPointArray(var anArray: array of TPoint; Count,Offsx,Offsy: integer);
var
  i: integer;
begin
  for i:=0 to Count-1 do
    begin
      Inc(anArray[i].X, OffsX);
      Inc(anArray[i].Y, OffsY);
      {aPoint:=anArray[i];
      aPoint.x:=aPoint.x+Offsx;
      aPoint.y:=aPoint.y+Offsy;
      anArray[i]:=aPoint;}
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDOffsetPointList(aList: TLMDPointList; Offsx,Offsy: integer);
var
  i: integer;
  aPoint: TPoint;
begin
  if not Assigned(aList) then
    exit;

  for i:=0 to aList.Count - 1 do
  begin
    aPoint := aList.Points[i];
    aPoint.x:=(aPoint.x) + Offsx;
    aPoint.y:=(aPoint.y) + Offsy;
    aList.PutPoint(i, aPoint);
  end;
end;

end.
