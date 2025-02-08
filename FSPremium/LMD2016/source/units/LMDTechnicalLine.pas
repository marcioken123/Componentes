unit LMDTechnicalLine;
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

LMDTechnicalLine unit (JH)
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Messages, Controls, //TMouseButton
  LMDGraphicControl;

type
  {-------------------------- TLMDTechnicalLine -------------------------------}
  TLMDTechnicalLineTypes = (lsStraightLeftToRight, lsStraightTopToBottom,
                            lsTopLeftToBottomRight, lsBottomLeftToTopRight,
                            lsTopLeftEdge, lsBottomLeftEdge, lsTopRightEdge, lsBottomRightEdge,
                            lsTopLeftCurve, lsBottomLeftCurve, lsTopRightCurve, lsBottomRightCurve);
  TLMDLineEndings = (leNothing, leOpenArrowUp, leOpenArrowDown, leOpenArrowRight, leOpenArrowLeft,
                            leClosedArrowUp, leClosedArrowDown, leClosedArrowLeft, leClosedArrowRight,
                            leDiamond, leCircle, leRectangle, leRoundRect, leParallelogramm, leComb,
                            leHalfCircleLeft, leHalfCircleRight, leHalfCircleUp, leHalfCircleDown);
  TLMDSignPlaces = (spEnd, spStart, spBoth, spNoWhere);

  TLMDTechnicalLine = class(TLMDGraphicControl)
  private
    FTechnicalLineType : TLMDTechnicalLineTypes;
    FLineEndingsign,
    FLineStartSign     : TLMDLineEndings;
    FLineSettings      : TPen;
    FArrowed           : Boolean;
    FShadowDepth,
    FSignSize          : Integer;
    FSignPlaces        : TLMDSignPlaces;
    FShadowColor,
    FFillColor         : TColor;
    FShapeOnlyMouse,
    FShadowVisible     : Boolean;
    drawnShape         : HRGN;

    procedure SetTechnicalLineType (Value : TLMDTechnicalLineTypes);
    procedure SetLineEnding (Value : TLMDLineEndings);
    procedure SetLineStart (Value : TLMDLineEndings);
    procedure SetSignSize (Value : Integer);
    procedure SetSignPlaces (Value : TLMDSignPlaces);
    procedure SetFillColor (Value : TColor);
    procedure SetShadowColor (Value : TColor);
    procedure SetShadowVisible (Value : Boolean);
    procedure SetShadowDepth (Value : Integer);
    procedure SetArrowed (Value : Boolean);
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;        
  protected
    function GetEmpty:Boolean;override;
    procedure Paint; override;
    procedure PaintIt (aRect : TRect);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  published
    property About;
    property Align;
    property Bevel;
    property Color;
    property DragCursor;
    property DragMode;
    property LineType : TLMDTechnicalLineTypes read FTechnicalLineType write SetTechnicalLineType
                        default lsStraightLeftToRight;
    property LineEndingsign : TLMDLineEndings read FLineEndingsign write SetLineEnding default leClosedArrowRight;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SignSize : Integer read FSignSize write SetSignSize default 40;
    property SignPlaces : TLMDSignPlaces read FSignPlaces write SetSignPlaces default spEnd;
    property LineStartSign : TLMDLineEndings read FLineStartSign write SetLineStart default leNothing;
    property LineSettings : TPen read FLineSettings write FLineSettings;
    property ShadowColor : TColor read FShadowColor write SetShadowColor default clBtnShadow;
    property ShadowVisible : Boolean read FShadowVisible write SetShadowVisible default False;
    property ShadowDepth : Integer read FShadowDepth write SetShadowDepth default 6;
    property FillColor : TColor read FFillColor write SetFillColor default clNone;
    property Arrowed : Boolean read FArrowed write SetArrowed default false;
    property ShapeOnly : Boolean read FShapeOnlyMouse write FShapeOnlyMouse default false;
    property Transparent;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {4.0}
    //properties
    property Anchors;
    property DragKind;
    property Constraints;
    //events
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

  end;

implementation

uses
  Types, SysUtils;

{----------------------------- Private ----------------------------------------}
procedure TLMDTechnicalLine.SetTechnicalLineType (Value : TLMDTechnicalLineTypes);
begin
  If FTechnicalLineType <> Value Then
    Begin
      FTechnicalLineType := Value;
      If FArrowed Then
        begin
          If FLineStartSign In [leOpenArrowUp, leOpenArrowDown, leOpenArrowRight, leOpenArrowLeft] Then
            Case FTechnicalLineType Of
              lsBottomLeftToTopRight, lsTopLeftToBottomRight, lsTopRightEdge, lsTopRightCurve, lsStraightLeftToRight
                                                                           : FLineStartSign := leOpenArrowLeft;
              lsTopLeftEdge, lsTopLeftCurve : FLineStartSign := leOpenArrowDown;
              lsBottomRightEdge, lsBottomRightCurve, lsStraightTopToBottom : FLineStartSign := leOpenArrowUp;
              lsBottomLeftCurve, lsBottomLeftEdge : FLineStartSign := leOpenArrowRight;
            End;
          If FLineStartSign In [leClosedArrowUp, leClosedArrowDown, leClosedArrowLeft, leClosedArrowRight] Then
            Case FTechnicalLineType Of
              lsBottomLeftToTopRight, lsTopLeftToBottomRight, lsTopRightEdge, lsTopRightCurve, lsStraightLeftToRight
                                                                           : FLineStartSign := leClosedArrowLeft;
              lsTopLeftEdge, lsTopLeftCurve : FLineStartSign := leClosedArrowDown;
              lsBottomRightEdge, lsBottomRightCurve, lsStraightTopToBottom : FLineStartSign := leClosedArrowUp;
              lsBottomLeftCurve, lsBottomLeftEdge : FLineStartSign := leClosedArrowRight;
            End;
          If FLineEndingSign In [leOpenArrowUp, leOpenArrowDown, leOpenArrowRight, leOpenArrowLeft] Then
            Case FTechnicalLineType Of
              lsBottomLeftToTopRight, lsTopLeftToBottomRight, lsTopLeftEdge, lsTopLeftCurve, lsStraightLeftToRight
                                                                     : FLineEndingSign := leOpenArrowRight;
              lsBottomLeftCurve, lsBottomLeftEdge : FLineEndingSign := leOpenArrowUp;
              lsTopRightEdge, lsTopRightCurve, lsStraightTopToBottom : FLineEndingSign := leOpenArrowDown;
              lsBottomRightEdge, lsBottomRightCurve : FLineEndingSign := leOpenArrowLeft;
            End;
          If FLineEndingSign In [leClosedArrowUp, leClosedArrowDown, leClosedArrowLeft, leClosedArrowRight] Then
            Case FTechnicalLineType Of
              lsBottomLeftToTopRight, lsTopLeftToBottomRight, lsTopLeftEdge, lsTopLeftCurve, lsStraightLeftToRight
                                                                     : FLineEndingSign := leClosedArrowRight;
              lsBottomLeftCurve, lsBottomLeftEdge : FLineEndingSign := leClosedArrowUp;
              lsTopRightEdge, lsTopRightCurve, lsStraightTopToBottom : FLineEndingSign := leClosedArrowDown;
              lsBottomRightEdge, lsBottomRightCurve : FLineEndingSign := leClosedArrowLeft;
            End;
        end;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetLineStart (Value : TLMDLineEndings);
begin
  If FLineStartSign <> Value Then
    Begin
      FLineStartSign := Value;
      If FSignPlaces In [spStart, spBoth] Then
        Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetLineEnding (Value : TLMDLineEndings);
begin
  If FLineEndingSign <> Value Then
    Begin
      FLineEndingSign := Value;
      If FSignPlaces In [spEnd, spBoth] Then
        Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetSignSize (Value : Integer);
begin
  If FSignSize <> Value Then
    Begin
      FSignSize := Value;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetFillColor (Value : TColor);
begin
  If FFillColor <> Value Then
    Begin
      FFillColor := Value;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetSignPlaces (Value : TLMDSignPlaces);
begin
  if FSignPlaces<>Value then
    begin
      FSignPlaces := Value;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetShadowColor (Value : TColor);
begin
  If FShadowColor <> Value Then
    Begin
      FShadowColor := Value;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetShadowVisible (Value : Boolean);
begin
  If FShadowVisible <> Value Then
    Begin
      FShadowVisible := Value;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetShadowDepth (Value : Integer);
begin
  If FShadowDepth <> Value Then
    Begin
      FShadowDepth := Value;
      Invalidate;
    End;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.SetArrowed (Value : Boolean);
begin
  If FArrowed <> Value Then
    Begin
      FArrowed := Value;
      Invalidate;
    End;
end;

{----------------------------- Protected --------------------------------------}
function TLMDTechnicalLine.GetEmpty:Boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.Paint;
var
  aRect : TRect;
  //helpRgn2,
  helpRgn : HRGN;
begin
  if not Transparent then FillControl;

  aRect:= ClientRect;
  if Bevel.BevelExtend <> 0 then
    aRect:=Bevel.PaintBevel(Canvas, aRect, (Bevel.BorderColor=Color) or Transparent);

  PaintIt (aRect);

  if FShapeOnlyMouse then
    begin
      //start a new path
      BeginPath (Canvas.Handle);
      //paint the object as path
      PaintIt (aRect);
      //end the new path object
      EndPath (Canvas.Handle);
      //remove any previous region
      if drawnShape <> 0 then DeleteObject (drawnShape);
      //convert the actual path to a region
      drawnShape := PathToRegion (Canvas.Handle);
      //the help region now contains the inner areas

      //we need to redraw it - the path seems to be corrupted after turning it
      //into a region :-(
      BeginPath (Canvas.Handle);
      //paint the object as path
      PaintIt (aRect);
      //end the new path object
      EndPath (Canvas.Handle);
      //Let's appply the pen settings on the path
      //this will size the path lines twice as large as they should be
      //but its the only way of including it
      WidenPath (Canvas.Handle);
      helpRgn := PathToRegion (Canvas.Handle);

      CombineRgn (drawnShape, drawnShape, helpRgn, RGN_OR);
      DeleteObject (helpRgn);
    end;
end; //end of paint

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.PaintIt (aRect : TRect);
Const
  { paint directions for line endings }
  dRight = 0;
  dLeft  = 1;
  dUp    = 2;
  dDown  = 3;
  { paint signs }
  LineStart = 0;
  LineEnd   = 1;

var
  hss, hpw : integer; { half sign size; half pen with }
  ShadowPen : TPen;
  DimensSign,
  FShdDepth,
  MyH, MyW : Integer;

  procedure LMDDrawGraphicalObject (a : TRect; Kind : TLMDLineEndings;
                                    Shadow : Boolean;ShadowDepth : Integer;
                                    OBrush, SBrush : TBrush;
                                    OPen, SPen : TPen;
                                    pCanvas : TCanvas);

     procedure PaintObject (a : TRect);
     begin
       With pCanvas Do
         Begin
           { recalc borders because of pen.width }
           If (Pen.Width <> 1) Then
             Begin
               a.Left := a.Left + Pen.Width div 2;
               a.Top := a.Top + Pen.Width div 2;
               a.Right := a.Right - Pen.Width div 2;
               a.Bottom := a.Bottom - Pen.Width div 2;
             End;
           { draw objects }
           Case Kind Of
             { draw an ellipse }
             leCircle:
                 Ellipse (a.Left, a.Top, a.Right, a.Bottom);
             { draw a rectangle }
             leRectangle:
                 Rectangle (a.Left, a.Top, a.Right, a.Bottom);
             { draw a triangle }
             leClosedArrowUp:
                 Polygon ([Point(a.Left, a.Bottom), Point(a.Left + (a.Right - a.Left) div 2, a.Top),
                          Point(a.Right, a.Bottom)]);
             leClosedArrowDown:
                 Polygon ([Point(a.Left, a.Top), Point(a.Left + (a.Right - a.Left) div 2, a.Bottom),
                          Point(a.Right, a.Top)]);
             leClosedArrowLeft:
                 Polygon ([Point(a.Right, a.Top), Point(a.left, a.Top + (a.Bottom - a.Top) div 2),
                          Point(a.Right, a.Bottom)]);
             leClosedArrowRight:
                 Polygon ([Point(a.Left, a.Top), Point(a.Right, a.Top + (a.Bottom - a.Top) div 2),
                          Point(a.Left, a.Bottom)]);
             leOpenArrowUp:
                 begin
                   MoveTo(a.Left, a.Bottom);
                   LineTo(a.Left + (a.Right - a.Left) div 2, a.Top);
                   LineTo(a.Right, a.Bottom);
                 end;
             leOpenArrowDown:
                 begin
                   MoveTo(a.Left, a.Top);
                   LineTo(a.Left + (a.Right - a.Left) div 2, a.Bottom);
                   LineTo(a.Right, a.Top);
                 end;
             leOpenArrowLeft:
                 begin
                   MoveTo(a.Right, a.Top);
                   LineTo(a.Left,a.Top + (a.Bottom - a.Top) div 2);
                   LineTo(a.Right, a.Bottom);
                 end;
             leOpenArrowRight:
                 begin
                   MoveTo(a.Left, a.Top);
                   LineTo(a.Right,a.Top + (a.Bottom - a.Top) div 2);
                   LineTo(a.Left, a.Bottom);
                 end;
             leDiamond:
                 Polygon ([Point(a.Left + (a.Right - a.Left) div 2, a.Top),
                           Point(a.Right, a.Top + (a.Bottom - a.Top) div 2),
                           Point(a.Left + (a.Right - a.Left) div 2, a.Bottom),
                           Point(a.Left, a.Top + (a.Bottom - a.Top) div 2)]);
             leRoundRect:
                 RoundRect (a.Left, a.Top, a.Right, a.Bottom,
                            (a.Right - a.Left) div 4, (a.Bottom - a.Top) div 4);
             leParallelogramm:
                 Polygon ([Point(a.Left + (a.Right - a.Left) div 4, a.Top),
                           Point(a.Right, a.Top),
                           Point(a.Right - (a.Right - a.Left) div 4, a.Bottom),
                           Point(a.Left, a.Bottom)]);
             leComb:
                 Polygon ([Point(a.Left + (a.Right - a.Left) div 2, a.Top),
                           Point(a.Right, a.Top + (a.Bottom - a.Top) div 4),
                           Point(a.Right, a.Bottom - (a.Bottom - a.Top) div 4),
                           Point(a.Left + (a.Right - a.Left) div 2, a.Bottom),
                           Point(a.Left, a.Bottom - (a.Bottom - a.Top) div 4),
                           Point(a.Left, a.Top + (a.Bottom - a.Top) div 4)]);
             leHalfCircleLeft:
                 begin
                   Pie (a.Left, a.Top, a.Right, a.Bottom,
                        a.Left + (a.Right - a.Left) div 2, a.Top,
                        a.Left + (a.Right - a.Left) div 2, a.Bottom);

                 end;
             leHalfCircleRight:
                 begin
                   Pie (a.Left, a.Top, a.Right, a.Bottom,
                        a.Left + (a.Right - a.Left) div 2, a.Bottom,
                        a.Left + (a.Right - a.Left) div 2, a.Top);
                 end;
             leHalfCircleUp:
                 begin
                   Pie (a.Left, a.Top, a.Right, a.Bottom,
                        a.Left, a.Top+(a.Bottom - a.Top) div 2,
                        a.Right, a.Top+(a.Bottom - a.Top) div 2);
                 end;
             leHalfCircleDown:
                 begin
                   Pie (a.Left, a.Top, a.Right, a.Bottom,
                        a.Right, a.Top + (a.Bottom - a.Top) div 2,
                        a.Left, a.Top + (a.Bottom - a.Top) div 2);
                 end;
           End;
         End;
     end; //end of paintobject

  begin
    a.Left   := a.Left + aRect.Left;
    a.Right  := a.Right + aRect.Left;
    a.Top    := a.Top + aRect.Top;
    a.Bottom := a.Bottom + aRect.Top;
    If Shadow Then
      begin
        { set shadow pen and brush }
        pCanvas.Pen.Assign(SPen);
        pCanvas.Brush.Assign(SBrush);
        If FFillColor <> clNone Then
          begin
            pCanvas.Brush.Color := SPen.Color;
            pCanvas.Brush.Style := bsSolid;
          end;
        { paint shadow }
        PaintObject (Rect (a.Left + ShadowDepth, a.Top + ShadowDepth,
                           a.Right, a.Bottom));
        { recalc the object size }
        a.Right := a.Right - ShadowDepth;
        a.Bottom := a.Bottom - ShadowDepth;
      end;

    { set pen and brush }
    pCanvas.Pen.Assign(OPen);
    pCanvas.Brush.Assign(OBrush);
    If FFillColor <> clNone Then
      begin
        pCanvas.Brush.Color := FFillColor;
        pCanvas.Brush.Style := bsSolid;
      end;
    { paint object }
    PaintObject (a);
  end; // end of procedure LMDDrawGraphicalObject

  procedure DrawShadowedLine (X1,Y1,X2,Y2 : Integer);
  begin
    With Canvas Do
      begin
        X1 := X1 + aRect.Left;
        X2 := X2 + aRect.Left;
        Y1 := Y1 + aRect.Top;
        Y2 := Y2 + aRect.Top;
        If FShadowVisible Then
          Begin
            Pen.Assign (ShadowPen);
            MoveTo (X1 + FShdDepth, Y1 + FShdDepth);
            LineTo (X2 + FShdDepth, Y2 + FShdDepth);
          End;
        Pen.Assign (FLineSettings);
        MoveTo (X1, Y1);
        LineTo (X2, Y2);
      end;
  end;

  procedure DrawShadowedArc (X1,Y1,X2,Y2,X3,Y3,X4,Y4 : Integer);
  begin
    X1 := X1 + aRect.Left;
    Y1 := Y1 + aRect.Top;
    X2 := X2 + aRect.Left;
    Y2 := Y2 + aRect.Top;
    X3 := X3 + aRect.Left;
    Y3 := Y3 + aRect.Top;
    X4 := X4 + aRect.Left;
    Y4 := Y4 + aRect.Top;
    With Canvas Do
      begin
        If FShadowVisible Then
          begin
            Pen.Assign (ShadowPen);
            Arc (X1 + FShdDepth, Y1 + FShdDepth, X2 + FShdDepth, Y2 + FShdDepth,
                 X3 + FShdDepth, Y3 + FShdDepth, X4 + FShdDepth, Y4 + FShdDepth);
          end;
        Pen.Assign (FLineSettings);
        Arc (X1, Y1, X2, Y2, X3, Y3, X4, Y4);
      end;
  end;

begin { paintit }

  HPW := FLineSettings.Width div 2;

  InflateRect (aRect, -(1 + HPW), -(1 + HPW));

  MyW := aRect.Right - aRect.Left;
  MyH := aRect.Bottom - aRect.Top;
  ShadowPen := TPen.Create;
  ShadowPen.Assign (FLineSettings);
  ShadowPen.Color := FShadowColor;

  Canvas.Brush.Style := bsClear;

  If FShadowVisible Then
    FShdDepth := FShadowDepth
  else
    FShdDepth := 0;

  With Canvas Do
    begin
      HSS := FSignSize DIV 2;
      DimensSign := FSignSize + FShdDepth;
      Case FTechnicalLineType Of
        { straight line from left to right or from right to left }
        lsStraightLeftToRight :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedLine (HPW, MyH div 2, MyW - FShdDepth - HPW, MyH div 2)
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (0, MyH div 2 - DimensSign div 2,
                                                         DimensSign, MyH div 2 + DimensSign div 2),
                                                   FLineStartSign,FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, MyH div 2 - (FShdDepth div 2),
                                             MyW-FShdDepth - HPW, MyH div 2 - (FShdDepth div 2));
                         end;
               spEnd   : begin
                           DrawShadowedLine (HPW, MyH div 2- (FShdDepth div 2),
                                             MyW-DimensSign, MyH div 2- (FShdDepth div 2));
                           LMDDrawGraphicalObject (Rect (MyW-DimensSign, MyH div 2- DimensSign div 2,
                                                         MyW, MyH div 2 + DimensSign div 2),
                                                   FLineEndingSign,FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLinesettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, MyH div 2 - DimensSign div 2,
                                                         DimensSign, MyH div 2 + DimensSign div 2),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, MyH div 2 - (FShdDepth div 2),
                                             MyW-DimensSign, MyH div 2 - (FShdDepth div 2));
                           LMDDrawGraphicalObject (Rect (MyW-DimensSign, MyH div 2 - DimensSign div 2,
                                                         MyW, MyH div 2 + DimensSign div 2),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
                   End;
        { straight line from top to bottom }
        lsStraightTopToBottom :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedLine (MyW div 2, HPW, MyW div 2, MyH - FShdDepth - HPW)
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (MyW div 2 - DimensSign div 2, 0,
                                                         MyW div 2 + DimensSign div 2, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (MyW div 2 - (FShdDepth div 2), DimensSign - FShdDepth,
                                             MyW div 2 - (FShdDepth div 2), MyH - FShdDepth - HPW);
                         end;
               spEnd   : begin
                           DrawShadowedLine (MyW div 2 - (FShdDepth div 2), HPW,
                                             MyW div 2 - (FShdDepth div 2), MyH - DimensSign);
                           LMDDrawGraphicalObject (Rect (MyW div 2 - DimensSign div 2,
                                                         MyH-DimensSign, MyW div 2 + DimensSign div 2, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen,Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (MyW div 2 - DimensSign div 2, 0,
                                                         MyW div 2 + DimensSign div 2, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (MyW div 2 - (FShdDepth div 2), DimensSign - FShdDepth,
                                             MyW div 2 - (FShdDepth div 2), MyH-DimensSign);
                           LMDDrawGraphicalObject (Rect (MyW div 2 - DimensSign div 2,
                                                         MyH - DimensSign, MyW div 2 + DimensSign div 2, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen,Canvas);
                         end;
             End;
        lsTopLeftToBottomRight :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedLine (0, 0, MyW - FShdDepth, MyH - FShdDepth)
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (FSignSize, HSS, MyW - FShdDepth, MyH - FShdDepth);
                         end;
               spEnd   : begin
                           DrawShadowedLine (0, 0, MyW-DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLinesettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (FSignSize, HSS, MyW - DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLinesettings, ShadowPen, Canvas);
                         end;
                   End;
        lsBottomLeftToTopRight :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedLine (0, MyH - FShdDepth, MyW-FShdDepth, 0)
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, MyH - HSS - FShdDepth,
                                             MyW - FShdDepth, 0);
                         end;
               spEnd   : begin
                           DrawShadowedLine (0, MyH, MyW - DimensSign, HSS);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLinesettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, MyH - HSS - FShdDepth,
                                             MyW - DimensSign, HSS);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLinesettings, ShadowPen, Canvas);
                         end;
                   End;
        { from the left bottom corner to the right top corner }
        lsTopLeftEdge  :
           If (FSignPlaces = spNoWhere) Then
             Begin
               DrawShadowedLine (0, MyH - FShdDepth, 0, 0);
               DrawShadowedLine (0, 0, MyW - FShdDepth, 0);
             End
           Else
             Case FSignPlaces Of
               spStart : begin
                           DrawShadowedLine (HSS, MyH - DimensSign, HSS, 0);
                           DrawShadowedLine (HSS, 0, MyW - FShdDepth, 0);
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spEnd   : begin
                           DrawShadowedLine (0, MyH - FShdDepth, 0, HSS);
                           DrawShadowedLine (0, HSS, MyW - DimensSign, HSS);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           DrawShadowedLine (HSS, MyH - DimensSign, HSS, HSS);
                           DrawShadowedLine (HSS, HSS, MyW - DimensSign, HSS);
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
             End;
        { from the right bottom corner to the left top corner }
        lsBottomLeftEdge   :
           If (FSignPlaces = spNoWhere) Then
             Begin
               DrawShadowedLine (0, 0, 0, MyH - FShdDepth);
               DrawShadowedLine (0, MyH - FShdDepth, MyW - FShdDepth, MyH - FShdDepth);
             End
           Else
             Case FSignPlaces Of
               spStart : begin
                           DrawShadowedLine (0, 0, 0, MyH - HSS - FShdDepth);
                           DrawShadowedLine (0, MyH - HSS - FShdDepth, MyW - DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spEnd   : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (HSS, DimensSign - FShdDepth, HSS, MyH - FShdDepth);
                           DrawShadowedLine (HSS, MyH - FShdDepth, MyW - FShdDepth, MyH - FShdDepth );
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (HSS, DimensSign - FShdDepth,
                                             HSS, MyH - HSS - FShdDepth);
                           DrawShadowedLine (HSS , MyH - HSS - FShdDepth, MyW - DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineStartSign, FShadowVisible,FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                               end;
                   End;
        { from the left top corner to the right bottom corner }
        lsTopRightEdge :
           If (FSignPlaces = spNoWhere) Then
             Begin
               DrawShadowedLine (0, 0, MyW - FShdDepth, 0);
               DrawShadowedLine (MyW - FShdDepth, 0, MyW - FShdDepth, MyH - FShdDepth);
             End
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible,FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, HSS, MyW - FShdDepth, HSS);
                           DrawShadowedLine (MyW - FShdDepth, HSS, MyW - FShdDepth, MyH - FShdDepth);
                         end;
               spEnd   : begin
                           DrawShadowedLine (0, 0, MyW - HSS - FShdDepth, 0);
                           DrawShadowedLine (MyW - HSS - FShdDepth, 0, MyW - HSS - FShdDepth, MyH - DimensSign);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (DimensSign - FShdDepth, HSS, MyW - HSS - FShdDepth, HSS);
                           DrawShadowedLine (MyW - HSS - FShdDepth, HSS, MyW - HSS - FShdDepth, MyH - DimensSign);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
             End;
        { from the right top corner to the left bottom corner }
        lsBottomRightEdge  :
           If (FSignPlaces = spNoWhere) Then
             Begin
               DrawShadowedLine (MyW - FShdDepth, 0, MyW - FShdDepth, MyH - FShdDepth);
               DrawShadowedLine (MyW - FShdDepth, MyH - FShdDepth, 0, MyH - FShdDepth);
             End
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (MyW - HSS - FShdDepth, FSignSize,
                                             MyW - HSS - FShdDepth, MyH - FShdDepth);
                           DrawShadowedLine (MyW - HSS - FShdDepth, MyH - FShdDepth,
                                             0, MyH - FShdDepth);
                         end;
               spEnd   : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (MyW - FShdDepth, 0,
                                             MyW - FShdDepth, MyH - HSS - FShdDepth);
                           DrawShadowedLine (MyW - FShdDepth, MyH - HSS - FShdDepth,
                                             FSignSize, MyH - HSS - FShdDepth);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedLine (MyW - HSS - FShdDepth, FSignSize,
                                             MyW - HSS - FShdDepth, MyH - HSS - FShdDepth);
                           DrawShadowedLine (MyW - HSS - FShdDepth, MyH - HSS - FShdDepth,
                                             FSignSize, MyH - HSS - FShdDepth);
                         end;
             End;
       { from the left bottom corner to the right top corner }
        lsTopLeftCurve :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedArc (0, 0, (MyW) * 2, (MyH) * 2, MyW - FShdDepth, 0, 0, MyH - FShdDepth)
           Else
             Case FSignPlaces Of
               spStart : begin
                           DrawShadowedArc (HSS, 0,
                                            MyW + MyW - HSS, (MyH - DimensSign) * 2,
                                            MyW - FShdDepth, 0,
                                            HSS, MyH - DimensSign);
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spEnd   : begin
                           DrawShadowedArc (0, HSS,
                                            (MyW - DimensSign)*2, MyH * 2 - HSS,
                                            MyW - DimensSign, HSS,
                                            0, MyH - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           DrawShadowedArc (HSS, HSS,
                                            MyW * 2 - FSignSize * 2 - HSS, MyH * 2 - FSignSize * 2 - HSS,
                                            MyW - DimensSign, HSS,
                                            HSS, MyH - DimensSign);
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
             End;
        { from the left top corner to the right bottom corner }
        lsTopRightCurve:
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedArc (- MyW + FShdDepth, 0, MyW - FShdDepth, MyH * 2 ,
                              MyW - FshdDepth, MyH - FshdDepth, 0, 0)
           Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (- MyW + DimensSign * 2 - FShdDepth, HSS,
                                            MyW - FShdDepth, HSS + 2 * MyH - DimensSign,
                                            MyW, MyH - FShdDepth, DimensSign - FShdDepth, HSS);
                         end;
               spEnd   : begin
                           DrawShadowedArc (- MyW + HSS + FShdDepth, 0,
                                            MyW - HSS - FShdDepth, MyH * 2 - DimensSign * 2,
                                            MyW - HSS - FShdDepth, MyH - DimensSign,
                                      0,0);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (- MyW + DimensSign * 2 + FShdDepth+ HSS,HSS,
                                            MyW - HSS - FShdDepth, 2 * ( MyH - DimensSign ) - ( HSS ),
                                            MyW - HSS - FShdDepth, MyH - DimensSign,
                                            DimensSign - FShdDepth, HSS);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
                   End;
        { from the right bottom corner to the left top corner }
        lsBottomLeftCurve :
           If (FSignPlaces = spNoWhere) Then
             DrawShadowedArc (FShdDepth, MyH - FShdDepth, MyW * 2 - FShdDepth, - MyH + FShdDepth,
                              0, 0, MyW - FShdDepth, MyH - FShdDepth)
           Else
             Case FSignPlaces Of
               spStart : begin
                           DrawShadowedArc (0,-MyH + HSS + FShdDepth,
                                            MyW * 2 - DimensSign * 2, MyH - HSS - FShdDepth,
                                            0, 0, MyW - DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
               spEnd   : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (HSS, FSignSize * 2 + FShdDepth - MyH,
                                            HSS + MyW * 2 - FSignSize, MyH - FShdDepth,
                                            HSS, FSignSize,
                                            MyW - FShdDepth, MyH);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, 0, DimensSign, DimensSign),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (HSS,- MyH + 2 * FSignSize + HSS + FShdDepth,
                                            MyW * 2 - DimensSign * 2 - HSS, MyH - HSS - FShdDepth,
                                            HSS, FSignSize,
                                            MyW - DimensSign, MyH - HSS - FShdDepth);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, MyH - DimensSign, MyW, MyH),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                         end;
             End;
        { from the right top corner to the left bottom corner }
        lsBottomRightCurve:
          If (FSignPlaces = spNoWhere) Then
               DrawShadowedArc (- MyW + FShdDepth,- MyH + FShdDepth, MyW - FShdDepth, MyH - FShdDepth,
                                0, MyH - FShdDepth, MyW, 0)
          Else
             Case FSignPlaces Of
               spStart : begin
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (- MyW + HSS + FShdDepth,- MyH + FSignSize * 2 + FShdDepth,
                                            MyW - HSS - FShdDepth, MyH - FShdDepth,
                                            0, MyH - FShdDepth,
                                            MyW - HSS - FShdDepth, DimensSign - FShdDepth);
                         end;
               spEnd   : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (- MyW + FSignSize * 2 + FShdDepth, - MyH + HSS,
                                            MyW - FShdDepth, MyH - HSS - FShdDepth,
                                            DimensSign - FShdDepth, MyH - HSS,
                                            MyW, 0);
                         end;
               spBoth  : begin
                           LMDDrawGraphicalObject (Rect (0, MyH - DimensSign, DimensSign, MyH),
                                                   FLineEndingSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           LMDDrawGraphicalObject (Rect (MyW - DimensSign, 0, MyW, DimensSign),
                                                   FLineStartSign, FShadowVisible, FShdDepth, Brush,
                                                   Brush, FLineSettings, ShadowPen, Canvas);
                           DrawShadowedArc (- MyW + FSignSize * 2 + HSS + FShdDepth, - MyH + SignSize * 2 + HSS+ FshdDepth,
                                            MyW - HSS - FShdDepth, MyH - HSS - FShdDepth,
                                            FSignSize, MyH - HSS - FShdDepth,
                                            MyW - HSS - FShdDepth, FSignSize);
                         end;
             End;
      end;
    end; //end of with canvas do
  ShadowPen.Free;
end; //end of paintit

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FShapeOnlyMouse and (drawnShape <> 0) then
    if not PtInRegion (drawnShape, Message.XPos+Left, Message.YPos+Top) then exit;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDTechnicalLine.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if FShapeOnlyMouse and (drawnShape <> 0) then
    if not PtInRegion (drawnShape, Message.XPos+Left, Message.YPos+Top) then exit;
  inherited;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDTechnicalLine.Create(AOwner: TComponent);
begin
  inherited create (AOwner);

  Width:=130;
  Height:=45;

  FLineSettings   := TPen.Create;
  FLineSettings.OnChange := GetChange;
  FSignSize       := 40;
  FSignPlaces     := spEnd;
  FLineEndingSign := leClosedArrowRight;
  FLineStartSign  := leNothing;
  FShadowDepth    := 6;
  FShadowColor    := clBtnShadow;
  FShadowVisible  := False;
  FFillColor      := clNone;
  FArrowed        := False;
  drawnShape      := 0;
  FShapeOnlyMouse := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDTechnicalLine.Destroy;
begin
  if drawnShape <> 0 then
    DeleteObject (drawnShape);
  FLineSettings.OnChange:=nil;
  FLineSettings.Free;
  inherited Destroy;
end;

end.
