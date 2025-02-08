unit LMDRegion;
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

LMDRegion unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Graphics,
  LMDObject, LMDRegionMask, LMDShadow, LMDGraph, LMDPointList;
  type
  TLMDRegionShape = (rsRect, rsRoundRect, rsBitmap, rsNoseRect, rsRoundNoseRect,
                     rsElliptic, rsStar, rsRoundShield, rsSharpShield, rsDiamond,
                     rsOctagon, rsComb, rsHalfRound, rsUserRegion, rsThinkBubble, rsRoundThinkBubble, rsEllipticThinkBubble,
                     rsPointList);

  TLMDRegionBorderStyle = (rbNone, rbLowered, rbRaised, rbSingle, rbSingleRaised, rbSingleLowered, rbRaisedpsb, rbLoweredpsb);
  TLMDBorderDrawEvent = procedure (Sender : TObject; Canvas : TCanvas; Rect : TRect) of object;
  TLMDExtPos = (epLeftTop, epTopLeft,  epTopRight, epRightTop,  epRightBottom, epBottomRight, epBottomLeft, epLeftBottom);

  { -------------------------------------------------------------------------- }
  TLMDRgnShadow = class(TLMDShadow)
  public
    constructor Create(Owner:TPersistent=nil); override;
  published
    property Style default hssNone;
  end;

  { -------------------------------------------------------------------------- }
  TLMDRegionBorder = class(TLMDObject)
  private
    FBorderStyle : TLMDRegionBorderStyle;
    FUpColor,
    FDnColor,
    FSiColor     : TColor;
    FWidth: Integer;

    procedure SetBorderStyle (aValue : TLMDRegionBorderStyle);
    procedure SetWidth (const Value: Integer);
    procedure SetColor (index : integer; aValue : TColor);
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent); override;
  published
    property Style : TLMDRegionBorderStyle read FBorderStyle write SetBorderStyle default rbSingle;
    property Width: Integer read FWidth write SetWidth default 2;
    property LightColor  : TColor index 0 read FUpColor write SetColor default clBtnHighLight;
    property ShadowColor : TColor index 1 read FDnColor write SetColor default clBtnShadow;
    property SingleColor : TColor index 2 read FSiColor write SetColor default clBlack;
  end;

  { -------------------------------------------------------------------------- }
  TLMDRegion = class(TLMDObject)
  private
    FShape    : TLMDRegionShape;
    FBorder   : TLMDRegionBorder;
    FMask     : TLMDRegionMask;
    FBubbleCount,
    FUserRgnDataSize,
    FRoundX,
    FRoundY      : Integer;
    FNewHandle,
    FHandleInUse : HRGN;
    FOwner       : TWinControl;
    FUserRgnData : PRGNDATA;
    FNosePos     : TLMDExtPos;
    FShadow      : TLMDRgnShadow;
    FOffsetRgn   : TPoint;
    FTurnOffShadow : Boolean;
    FPointList   : TLMDPointList;

    procedure SetRegionShape (aValue : TLMDRegionShape);
    procedure SetBorder (aValue : TLMDRegionBorder);
    procedure SetMask (aValue : TLMDRegionMask);
    procedure SetInteger (index : Integer; aValue : Integer);
    procedure SetShadow (aValue : TLMDRgnShadow);
    procedure SetNosePos (aValue : TLMDExtPos);

//    procedure DeleteHandle (var aValue : HRGN);
    procedure GetPointListChange (Sender : TObject);

    procedure WriteData (Writer : TWriter);
    procedure ReadData (Reader : TReader);
  protected
    procedure DefineProperties (Filer : TFiler); override;
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;

    procedure Assign (Source : TPersistent); override;

    procedure CreateRegion (aRect : TRect); dynamic;
    procedure CreateSpecialRectRgn (const aRect : TRect);
    procedure SetRegion;
    procedure DrawShadow(aCanvas : TCanvas;var aRect : TRect);
    procedure FreeRegion;
    procedure PaintRegionShape (aCanvas : TCanvas; aRect : TRect); dynamic;
    procedure SetUserRgn (aRGN : HRGN);
    procedure SetUserPolygonRgn (const points : array of TPoint);

    property CreatedHandle : HRGN read FNewHandle;//new creted handle - use SetRegion to make it the currently used one
    property Handle : HRGN read FHandleInUse;     //handle currently used by a control
    property Border : TLMDRegionBorder read FBorder write SetBorder;
    property Owner : TWinControl read FOwner write FOwner;
    property OffsetRegion : TPoint read FOffsetRgn write FOffsetRgn;
    property TurnOffShadow : Boolean read FTurnOffShadow write FTurnOffShadow default false;
  published
    property Points : TLMDPointList read FPointList write FPointList;
    property Shape  : TLMDRegionShape read FShape write SetRegionShape default rsRoundRect;
    property ExtPos : TLMDExtPos read FNosePos write SetNosePos default epLeftTop;
    property Mask   : TLMDRegionMask read FMask write SetMask;
    property RoundX : Integer index 0 read FRoundX write SetInteger default 20;
    property RoundY : Integer index 1 read FRoundY write SetInteger default 20;
    property Shadow : TLMDRgnShadow read FShadow write SetShadow;
  end;

  { -------------------------------------------------------------------------- }
  TLMDBorderRegion = class (TLMDRegion)
  published
    property Border;
  end;

  function LMDCreateDiamondRgn (aRect : TRect) : HRGN;
  function LMDCreateStarRgn (aRect : TRect) : HRGN;
  function LMDCreateOctagonRgn (aRect : TRect) : HRGN;
  function LMDCreateCombRgn (aRect : TRect) : HRGN;
  function LMDCreateRoundShieldRgn (aRect : TRect) : HRGN;
  function LMDCreateSharpShieldRgn (aRect : TRect) : HRGN;
  function LMDCreateNoseRectRgn (aRect : TRect; ns : Integer; Pos : TLMDExtPos) : HRGN;
  function LMDCreateRoundNoseRectRgn (aRect : TRect; ns, xround, yround : Integer; const Pos : TLMDExtPos) : HRGN;
  function LMDCreateThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos) : HRGN;
  function LMDCreateRoundThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos; roundx, roundy : Integer) : HRGN;
  function LMDCreateEllipticThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos) : HRGN;

  procedure LMDFrameDiamondRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameStarRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameOctagonRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameCombRgn (aCanvas : TCanvas; aRect :  TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameRoundShieldRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameSharpShieldRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameEllipticRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameRoundRectRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; RX, RY : Integer; AFrameWidth: integer = 2);
  procedure LMDFrameHalfRoundRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameRectRgn (aCanvas : TCanvas; aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameThinkBubbleRgn (aCanvas : TCanvas; aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameRoundThinkBubbleRgn (aCanvas : TCanvas; aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos; roundx, roundy : Integer;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
  procedure LMDFrameEllipticThinkBubbleRgn (aCanvas : TCanvas; aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);

implementation

uses
  Types,
  LMDClass;

type
  TLMDCircle = Record
    R : Integer;
  case Integer of
     0: ( X : Integer;
          Y : Integer);

     1 : ( M : TPoint);
    end;

{ ---------------------------------------------------------------------------- }
{ ---------------------------------------------------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure LMDChangeColors (var col1, col2 : TColor);
var
  c : TColor;
begin
  c := col1;
  col1 := col2;
  col2 := c;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateDiamondRgn (aRect : TRect) : HRGN;
var
  p : Array[0..3] of TPoint;
begin
  with aRect do
    begin
      p[0] := Point(Left + (Right - Left) div 2, Top);
      p[1] := Point(Left, Top + (Bottom - Top) div 2);
      p[2] := Point(Left + (Right - Left) div 2, Bottom);
      p[3] := Point(Right, Top + (Bottom - Top) div 2);
      result := CreatePolygonRgn (p, 4, ALTERNATE);
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateStarRgn (aRect : TRect) : HRGN;
var
  p : Array[0..9] of TPoint;
begin
  with aRect do
    begin
      p[0] := Point(Left + (Right - Left) div 2, Top);
      p[1] := Point(Left+Round(0.65*(Right-Left)),Top+Round(0.38*(Bottom-Top)));
      p[2] := Point(Right,Top+Round(0.38*(Bottom-Top)));
      p[3] := Point(Left+Round(0.7*(Right-Left)),Top+Round(0.6*(Bottom-Top)));
      p[4] := Point(Left+Round(0.85*(Right-Left)),Bottom);
      p[5] := Point(Left+(Right-Left)div 2,Top+Round(0.75*(Bottom-Top)));
      p[6] := Point(Left+Round(0.15*(Right-Left)),Bottom);
      p[7] := Point(Left+Round(0.3*(Right-Left)),Top+Round(0.6*(Bottom-Top)));
      p[8] := Point(Left,Top+Round(0.38*(Bottom-Top)));
      p[9] := Point(Left+Round(0.35*(Right-Left)),Top+Round(0.38*(Bottom-Top)));

      result := CreatePolygonRgn (p, 10, ALTERNATE);
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateOctagonRgn (aRect : TRect) : HRGN;
var
  p : Array[0..7] of TPoint;
begin
  with aRect do
    begin
      p[0] := Point(Left + (Right - Left) div 3 * 2, Top);
      p[1] := Point(Left + (Right - Left) div 3, Top);
      p[2] := Point(Left, Top + (Bottom - Top) div 3);
      p[3] := Point(Left, Top + (Bottom - Top) div 3 * 2);
      p[4] := Point(Left + (Right - Left) div 3, Bottom);
      p[5] := Point(Left + (Right - Left) div 3 * 2, Bottom);
      p[6] := Point(Right, Top + (Bottom - Top) div 3 * 2);
      p[7] := Point(Right, Top + (Bottom - Top) div 3);
      result := CreatePolygonRgn (p, 8, ALTERNATE);
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateCombRgn (aRect : TRect) : HRGN;
var
  p : Array[0..5] of TPoint;
begin
  with aRect do
    begin
      p[0] := Point(Left + (Right - Left) div 2, Top);
      p[1] := Point(Left, Top + (Bottom - Top) div 4);
      p[2] := Point(Left, Top + (Bottom - Top) div 4 * 3);
      p[3] := Point(Left + (Right - Left) div 2, Bottom);
      p[4] := Point(Right, Top + (Bottom - Top) div 4 * 3);
      p[5] := Point(Right, Top + (Bottom - Top) div 4);
      result := CreatePolygonRgn (p, 6, ALTERNATE);
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateRoundShieldRgn (aRect : TRect) : HRGN;
var
  w, h : Integer;
  r2   : HRGN;
begin
  w := aRect.Right - aRect.Left;
  h := aRect.Bottom - aRect.Top;
  result := CreateEllipticRgn (0,  h, w, - (h - h div 5));
  r2 := CreateEllipticRgn (- w div 2, - h div 5, w div 2, h div 5);
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject (r2);
  r2 := CreateEllipticRgn (w div 2, - h div 5, w + w div 2, h div 5);
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject (r2);

  //delete any region parts above visible area
  r2 := CreateRectRgn (0, -40, w, 0);   //-40 max depth of shadow object
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject(r2);
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateSharpShieldRgn (aRect : TRect) : HRGN;
var
  r2 : HRGN;
  w, h : Integer;
begin
  w := aRect.Right - aRect.Left;
  h := aRect.Bottom - aRect.Top;

  result := CreateEllipticRgn (- w,- h * 8 div 7, w , h * 8 div 7);

  r2 := CreateEllipticRgn (0, - h * 8 div 7, 2* w, h * 8 div 7);
  CombineRgn (result, result, r2, RGN_AND);
  DeleteObject (r2);

  r2 := CreateEllipticRgn (- w div 2, -h div 5, w div 2, h div 5);
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject (r2);

  r2 := CreateEllipticRgn (w div 2, -h div 5, w + w div 2, h div 5);
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject (r2);

  //delete any region parts above visible area
  r2 := CreateRectRgn (0, -40, w, 0); //-40 max depth of shadow object
  CombineRgn (result, result, r2, RGN_DIFF);
  DeleteObject(r2);
end;

{ ---------------------------------------------------------------------------- }
//helper for LMDCreateNoseRectRgn, LMDCreateRoundNoseRectRgn

procedure LMDBuildUpNose (var aRect : TRect; ns : Integer; Pos : TLMDExtPos; off : Integer; var p: array of TPoint);
var
//  p : Array[0..2] of TPoint;
  l : Integer;
begin

  with aRect do
    begin

      case Pos of
        epTopLeft,
        epTopRight,
        epLeftTop,
        epRightTop     : inc (Top, ns);
        epRightBottom,
        epBottomRight,
        epBottomLeft,
        epLeftBottom   : dec (Bottom, ns);
      end;

      case Pos of
        epLeftTop,
        epTopLeft,
        epBottomLeft,
        epLeftBottom  : inc (Left, ns);
        epRightTop,
        epTopRight,
        epRightBottom,
        epBottomRight : dec (Right, ns);
      end;

      l := Round(SQRT ( 2* SQR (ns)));

      case Pos of
        epTopLeft     : begin
                          p[0] := Point(Left - ns, Top - ns);
                          p[1] := Point(Left + off, Top);
                          p[2] := Point(Left + l + off, Top);
                        end;
        epTopRight    : begin
                          p[0] := Point(Right + ns, Top - ns);
                          p[1] := Point(Right - off, Top);
                          p[2] := Point(Right - l - off, Top);
                        end;
        epRightTop    : begin
                          p[0] := Point(Right + ns, Top - ns);
                          p[1] := Point(Right, Top + off);
                          p[2] := Point(Right, Top + l + off);
                        end;
        epRightBottom : begin
                          p[0] := Point(Right + ns, Bottom + ns);
                          p[1] := Point(Right, Bottom - off);
                          p[2] := Point(Right, Bottom - off - l);
                        end;
        epBottomRight : begin
                          p[0] := Point(Right + ns, Bottom + ns);
                          p[1] := Point(Right - off, Bottom);
                          p[2] := Point(Right - off -l, Bottom);
                        end;
        epBottomLeft  : begin
                          p[0] := Point(Left - ns, Bottom + ns);
                          p[1] := Point(Left + off, Bottom);
                          p[2] := Point(Left + off + l, bottom);
                        end;
        epLeftBottom  : begin
                          p[0] := Point(Left - ns, Bottom + ns);
                          p[1] := Point(Left, Bottom - off);
                          p[2] := Point(Left, Bottom - off - l);
                        end;
        epLeftTop     : begin
                          p[0] := Point(Left - ns, Top - ns);
                          p[1] := Point(Left, Top + off);
                          p[2] := Point(Left, Top + off + l);
                        end;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateNoseRectRgn (aRect : TRect; ns : Integer; Pos : TLMDExtPos) : HRGN;
var
  h2 : HRGN;
  p : Array[0..2] of TPoint;
begin
  with aRect do
    begin

      LMDBuildUpNose (aRect, ns, Pos, 5, p);

      h2 := CreatePolygonRgn (p, 3, ALTERNATE);

      result := CreateRectRgn (Left, Top, Right, Bottom);

      CombineRgn (result, result, h2, RGN_OR);

      DeleteObject (h2);
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateRoundNoseRectRgn (aRect : TRect; ns, xround, yround : Integer;
    const Pos : TLMDExtPos) : HRGN;
var
  h2 : HRGN;
  LOffset : Integer;
  p : Array[0..2] of TPoint;
begin
  with aRect do
    begin
      LOffset := 5;
      case pos of
        epBottomRight,
        epBottomLeft,
        epTopLeft,
        epTopRight     : LOffset := xround;
        epLeftBottom,
        epRightBottom,
        epRightTop,
        epLeftTop      : LOffset := yround;
      end;

      LMDBuildUpNose (aRect, ns, Pos, LOffset, p);

      h2 := CreatePolygonRgn (p, 3, ALTERNATE);

      result := CreateRoundRectRgn (Left, Top, Right, Bottom, xround, yround);

      CombineRgn (result, result, h2, RGN_OR);

      DeleteObject (h2);
    end;
end;

{ ---------------------------------------------------------------------------- }
//helper for LMDCreateNoseRectRgn, LMDCreateRoundNoseRectRgn
procedure LMDBuildUpBubbles (var aRect : TRect; ns, bc : Integer; const Pos : TLMDExtPos; off : Integer;
    var p: array of TLMDCircle);
//p : PLMDCircle);
var
//  p : Array[0..2] of TPoint;
  step,
  l : Real;
  i : Integer;
//  stepper : TLMDCircle;
//  stepper : PLMDCircle;
begin

  with aRect do
    begin

      case Pos of
        epTopLeft,
        epTopRight,
        epLeftTop,
        epRightTop     : inc (Top, ns);
        epRightBottom,
        epBottomRight,
        epBottomLeft,
        epLeftBottom   : dec (Bottom, ns);
      end;

      case Pos of
        epLeftTop,
        epTopLeft,
        epBottomLeft,
        epLeftBottom  : inc (Left, ns);
        epRightTop,
        epTopRight,
        epRightBottom,
        epBottomRight : dec (Right, ns);
      end;

      inc(bc);

      step := ((2 * Pi * ns / 4) / (bc-1)); // 1/4 umfang / anzahl der kreise  = maximaler Radius eines Kreises

      step := step / (bc-1); //wachstumswert von einem Kreisumfang zum nächsten

  //    stepper := p;

      for i := 0 to bc + 1 do
        begin
          //winkel in bogenmass
          l := pi / 180 * ((90 / bc) *i);

          case Pos of
            epTopLeft     : begin //1.57 = 90° in Bogenmass
//                              stepper.X := Left -ns + Round((cos(1.57-l))*ns);
//                              stepper.Y := Top -  Round((sin(1.57-l))*ns);
                              p[i].X := Left -ns + Round((cos(1.57-l))*ns);
                              p[i].Y := Top -  Round((sin(1.57-l))*ns);
                            end;
            epTopRight    : begin
//                              stepper.X := Right +ns - Round(cos(1.57-l)*ns);
//                              stepper.Y := Top - Round(sin(1.57+l)*ns);
                              p[i].X := Right +ns - Round(cos(1.57-l)*ns);
                              p[i].Y := Top - Round(sin(1.57+l)*ns);
                            end;
            epRightTop    : begin
//                              stepper.X := Right + Round(cos(l)*ns);
//                              stepper.Y := Top - ns + Round(sin(l)*ns);
                              p[i].X := Right + Round(cos(l)*ns);
                              p[i].Y := Top - ns + Round(sin(l)*ns);
                            end;
            epRightBottom : begin
//                              stepper.X := Right + Round(cos(l)*ns);
//                              stepper.Y := Bottom +ns -  Round(sin(l)*ns);
                              p[i].X := Right + Round(cos(l)*ns);
                              p[i].Y := Bottom +ns -  Round(sin(l)*ns);
                            end;
            epBottomRight : begin
//                              stepper.X := Right + ns - Round(cos(1.57-l)*ns);
//                              stepper.Y := Bottom + Round(sin(1.57-l)*ns);
                              p[i].X := Right + ns - Round(cos(1.57-l)*ns);
                              p[i].Y := Bottom + Round(sin(1.57-l)*ns);
                            end;
            epBottomLeft  : begin
//                              stepper.X := Left -ns + Round(cos(1.57-l)*ns);
//                              stepper.Y := Bottom + Round(sin(1.57-l)*ns);
                              p[i].X := Left -ns + Round(cos(1.57-l)*ns);
                              p[i].Y := Bottom + Round(sin(1.57-l)*ns);
                            end;
            epLeftBottom  : begin
//                              stepper.X := Left - Round(cos(l)*ns);
//                              stepper.Y := Bottom +ns - Round(sin(l)*ns);
                              p[i].X := Left - Round(cos(l)*ns);
                              p[i].Y := Bottom +ns - Round(sin(l)*ns);
                            end;
            epLeftTop     : begin
//                              stepper.X := Left - Round(cos(l)*ns);
//                              stepper.Y := Top - ns + Round(sin(l)*ns);
                              p[i].X := Left - Round(cos(l)*ns);
                              p[i].Y := Top - ns + Round(sin(l)*ns);
                            end;
          end;
//          stepper.R := Round(step * i);
          p[i].R := Round(step * i);
//          inc(Integer(stepper), sizeof (TLMDCircle));
        end;

    end;
end;

{ ---------------------------------------------------------------------------- }
//helper for creating bubbled regions
function LMDBuildUpBubbleRgn (var aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos) : HRGN;
var
  h2 : HRGN;
  stepper: TLMDCircle;
//  p : PLMDCircle;
  p : array of TLMDCircle;
  i : Integer;
begin
  result := CreateRectRgn (0,0,1,1); // get main region (rect, roundrect, elliptic)

  SetLength(p, bc + 3);
//  p := AllocMem  (SizeOf (TLMDCircle) * (bc + 3));

  with aRect do
    begin

      LMDBuildUpBubbles (aRect, bs, bc, Pos, 5, p);

//      stepper := p;

      for i := 0 to bc + 1 do
        begin
          stepper := p[i];
          h2 := CreateEllipticRgn (stepper.X - stepper.R div 2, stepper.Y - stepper.R div 2,
                                   stepper.X + stepper.R div 2,stepper.Y + stepper.R div 2);
          CombineRgn (result, result, h2, RGN_OR);
          DeleteObject(h2);
//          inc(Integer(stepper), sizeof (TLMDCircle));
        end;

    end;

//  FreeMem (p, SizeOf (TLMDCircle) * (bc + 3));

end;

{ ---------------------------------------------------------------------------- }
function LMDCreateThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos) : HRGN;
var
  h2 : HRGN;
begin
  h2 := LMDBuildUpBubbleRgn (aRect, bs, bc, Pos);
  with aRect do
    result := CreateRectRgn (Left, Top, Right, Bottom);

  CombineRgn (result, result, h2, RGN_OR);

  DeleteObject (h2);
end;

{ ---------------------------------------------------------------------------- }
function LMDCreateRoundThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos; roundx, roundy : Integer) : HRGN;
var
  h2 : HRGN;
begin
  h2 := LMDBuildUpBubbleRgn (aRect, bs, bc, Pos);
  with aRect do
    result := CreateRoundRectRgn (Left, Top, Right, Bottom, roundx, roundy);

  CombineRgn (result, result, h2, RGN_OR);

  DeleteObject (h2);

end;

{ ---------------------------------------------------------------------------- }
function LMDCreateEllipticThinkBubbleRgn (aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos) : HRGN;
var
  h2 : HRGN;
begin
  h2 := LMDBuildUpBubbleRgn (aRect, bs, bc, Pos);
  with aRect do
    result := CreateEllipticRgn (Left, Top, Right, Bottom);

  CombineRgn (result, result, h2, RGN_OR);

  DeleteObject (h2);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameBubbles (aCanvas : TCanvas;var aRect : TRect;bs, bc : Integer; Pos : TLMDExtPos;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
//  stepper,
//  p : PLMDCircle;
  stepper: TLMDCircle;
  p : array of TLMDCircle;
  i : Integer;
  hRect : TRect;
begin

  SetLength(P, (bc + 3));
//  p := AllocMem  (SizeOf (TLMDCircle) * (bc + 3));

  with aRect do
    begin

      LMDBuildUpBubbles (aRect, bs, bc, Pos, 5, p);

//      stepper := p;

      for i := 0 to bc + 1 do
        begin
          stepper := p[i];
          hRect := Rect (stepper.X - stepper.R div 2 , stepper.Y - stepper.R div 2,
                                   stepper.X + stepper.R div 2,stepper.Y + stepper.R div 2);
          LMDFrameEllipticRgn (aCanvas, hRect, colorUp, colorDn, colorSi, style, AFrameWidth);
          ExcludeClipRect (aCanvas.Handle, hRect.Left, hRect.Top, hRect.Right, hRect.Bottom);
//          inc(Integer(stepper), sizeof (TLMDCircle));
        end;

    end;

//  FreeMem (p, SizeOf (TLMDCircle) * (bc + 3));

end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameThinkBubbleRgn (aCanvas : TCanvas;aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
begin
  LMDFrameBubbles (aCanvas, aRect, bs, bc, Pos, colorUp, colorDn, colorSi, style, AFrameWidth);
  LMDFrameRectRgn (aCanvas, aRect, colorUp, colorDn, colorSi, style, AFrameWidth);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameRoundThinkBubbleRgn (aCanvas : TCanvas;aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos; roundx, roundy : Integer;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
begin
  LMDFrameBubbles (aCanvas, aRect, bs, bc, Pos, colorUp, colorDn, colorSi, style, AFrameWidth);
  LMDFrameRoundRectRgn (aCanvas, aRect, colorUp, colorDn, colorSi, style, roundx, roundy, AFrameWidth);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameEllipticThinkBubbleRgn (aCanvas : TCanvas;aRect : TRect; bs, bc : Integer; Pos : TLMDExtPos;colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
begin
  LMDFrameBubbles (aCanvas, aRect, bs, bc, Pos, colorUp, colorDn, colorSi, style, AFrameWidth);
  LMDFrameEllipticRgn (aCanvas, aRect, colorUp, colorDn, colorSi, style, AFrameWidth);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameNoseRectRgn (aCanvas : TCanvas;aRect : TRect; ns : Integer; Pos : TLMDExtPos; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  p : Array[0..2] of TPoint;
begin
  LMDBuildUpNose (aRect, ns, Pos, 5, p);
  ExcludeClipRect (aCanvas.Handle, p[1].X - 2,P[1].Y - 2, p[2].X + 2, p[2].Y + 2);
  LMDFrameRectRgn (aCanvas, aRect, colorUp, colorDn, colorSi, style, AFrameWidth);
  IntersectClipRect (aCanvas.Handle, p[1].X - 2,P[1].Y - 2, p[2].X + 2, p[2].Y + 2);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameRoundNoseRectRgn (aCanvas : TCanvas;aRect : TRect; ns : Integer; Pos : TLMDExtPos; xround, yround : Integer; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  offset : Integer;
  p : Array[0..2] of TPoint;
begin

   offset := 5;

   case pos of
     epBottomRight,
     epBottomLeft,
     epTopLeft,
     epTopRight     : offset := xround;
     epLeftBottom,
     epRightBottom,
     epRightTop,
     epLeftTop      : offset := yround;
   end;

  LMDBuildUpNose (aRect, ns, Pos, offset, p);
  ExcludeClipRect (aCanvas.Handle, p[1].X - 4,P[1].Y - 4, p[2].X + 4, p[2].Y + 4);
  LMDFrameRoundRectRgn (aCanvas, aRect, colorUp, colorDn, colorSi, style, xround, yround, AFrameWidth);
  IntersectClipRect (aCanvas.Handle, p[1].X - 4,P[1].Y - 4, p[2].X + 4, p[2].Y + 4);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameDiamondRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);

var
  p : Array[0..3] of TPoint;
  LOldPenWidth: Integer;

  procedure calc_p;
  begin
    with aRect do
      begin
        p[0] := Point(Left + (Right - Left) div 2, Top);
        p[1] := Point(Left, Top + (Bottom - Top) div 2);
        p[2] := Point(Left + (Right - Left) div 2, Bottom);
        p[3] := Point(Right, Top + (Bottom - Top) div 2);
      end;
  end;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorUp;
//        MoveTo (Left + (Right - Left) div 2, Top);
        MoveTo (Right, Top + (Bottom - Top) div 2);
        LineTo (Left + (Right - Left) div 2, Top);
        LineTo (Left, Top + (Bottom - Top) div 2);
        Pen.Color := colorDn;
        LineTo (Left + (Right - Left) div 2, Bottom);
        LineTo (Right, Top + (Bottom - Top) div 2);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    calc_p;
    case style of
      rbSingle : with aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                     InflateRect (aRect, -1, -1);
                     paintUD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1, -1);
                     Pen.Color := colorSi;
                     MoveTo (Left + (Right - Left) div 2, Bottom);
                     LineTo (Right, Top + (Bottom - Top) div 2);
                     LineTo (Left + (Right - Left) div 2, Top);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameStarRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  p : Array[0..9] of TPoint;
  LOldPenWidth: Integer;

  procedure calc_p;
  begin
    with aRect do
      begin
        p[0] := Point(Left + (Right - Left) div 2, Top);
        p[1] := Point(Left+Round(0.65*(Right-Left)),Top+Round(0.38*(Bottom-Top)));
        p[2] := Point(Right,Top+Round(0.38*(Bottom-Top)));
        p[3] := Point(Left+Round(0.7*(Right-Left)),Top+Round(0.6*(Bottom-Top)));
        p[4] := Point(Left+Round(0.85*(Right-Left)),Bottom);
        p[5] := Point(Left+(Right-Left)div 2,Top+Round(0.75*(Bottom-Top)));
        p[6] := Point(Left+Round(0.15*(Right-Left)),Bottom);
        p[7] := Point(Left+Round(0.3*(Right-Left)),Top+Round(0.6*(Bottom-Top)));
        p[8] := Point(Left,Top+Round(0.38*(Bottom-Top)));
        p[9] := Point(Left+Round(0.35*(Right-Left)),Top+Round(0.38*(Bottom-Top)));
      end;
  end;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorDn;
        MoveTo (p[0].X, p[0].Y);
        LineTo (p[1].X, p[1].Y);
        Pen.Color := colorUp;
        LineTo (p[2].X, p[2].Y);
        Pen.Color := colorDn;
        LineTo (p[3].X, p[3].Y);
        Pen.Color := colorUp;
        LineTo (p[4].X, p[4].Y);
        Pen.Color := colorDn;
        LineTo (p[5].X, p[5].Y);
        LineTo (p[6].X, p[6].Y);
        Pen.Color := colorUp;
        LineTo (p[7].X, p[7].Y);
        Pen.Color := colorDn;
        LineTo (p[8].X, p[8].Y);
        Pen.Color := colorUp;
        LineTo (p[9].X, p[9].Y);
        LineTo (p[0].X, p[0].Y);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    calc_p;
    case style of
      rbSingle : with aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                     InflateRect (aRect, -2, -2);
                     calc_p;
                     paintUD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -3 , -3);
                     calc_p;
                     Pen.Color := colorSi;
                     MoveTo (p[0].X, p[0].Y);
                     LineTo (p[1].X, p[1].Y);
                     MoveTo (p[2].X, p[2].Y);
                     LineTo (p[3].X, p[3].Y);
                     MoveTo (p[4].X, p[4].Y);
                     LineTo (p[5].X, p[5].Y);
                     LineTo (p[6].X, p[6].Y);
                     MoveTo (p[7].X, p[7].Y);
                     LineTo (p[8].X, p[8].Y);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameOctagonRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  p : Array[0..7] of TPoint;
  i : Integer;
  LOldPenWidth: Integer;

  procedure calc_p;
  begin
    with aRect do
      begin
        p[0] := Point(Left + (Right - Left) div 3 * 2, Top);
        p[1] := Point(Left + (Right - Left) div 3, Top);
        p[2] := Point(Left, Top + (Bottom - Top) div 3);
        p[3] := Point(Left, Top + (Bottom - Top) div 3 * 2);
        p[4] := Point(Left + (Right - Left) div 3, Bottom);
        p[5] := Point(Left + (Right - Left) div 3 * 2, Bottom);
        p[6] := Point(Right, Top + (Bottom - Top) div 3 * 2);
        p[7] := Point(Right, Top + (Bottom - Top) div 3);
      end;
  end;

  procedure paintUD;
  var
    i : Integer;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorUp;
        MoveTo (p[7].X, p[7].Y);
        for i := 0 to 3 do
          LineTo (p[i].X, p[i].Y);
        Pen.Color := colorDn;
        for i := 4 to 7 do
          LineTo (p[i].X, p[i].Y);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    calc_p;
    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                     InflateRect (aRect, -1, -1);
                     calc_p;
                     paintUD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1 , -1);
                     calc_p;
                     Pen.Color := colorSi;
                     MoveTo (p[3].X, p[3].Y);
                     for i := 4 to 7 do
                       LineTo (p[i].X, p[i].Y);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameCombRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  p : Array[0..5] of TPoint;
  LOldPenWidth: Integer;

  procedure calc_p;
  begin
    with aRect do
      begin
        p[0] := Point(Left + (Right - Left) div 2, Top);
        p[1] := Point(Left, Top + (Bottom - Top) div 4);
        p[2] := Point(Left, Top + (Bottom - Top) div 4 * 3);
        p[3] := Point(Left + (Right - Left) div 2, Bottom);
        p[4] := Point(Right, Top + (Bottom - Top) div 4 * 3);
        p[5] := Point(Right, Top + (Bottom - Top) div 4);
      end;
  end;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorUp;
        MoveTo (p[5].X, p[5].Y);
        LineTo (p[0].X, p[0].Y);
        LineTo (p[1].X, p[1].Y);
        LineTo (p[2].X, p[2].Y);
        Pen.Color := colorDn;
        LineTo (p[3].X, p[3].Y);
        LineTo (p[4].X, p[4].Y);
        LineTo (p[5].X, p[5].Y);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    calc_p;
    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Polygon (p);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                    begin
                      Pen.Color := colorSi;
                      Polygon (p);
                      InflateRect (aRect, -1, -1);
                      calc_p;
                      paintUD;
                    end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1 , -1);
                     calc_p;
                     Pen.Color := colorSi;
                     MoveTo (p[2].X, p[2].Y);
                     LineTo (p[3].X, p[3].Y);
                     LineTo (p[4].X, p[4].Y);
                     LineTo (p[5].X, p[5].Y);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameRoundShieldRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  w, h : integer;
  LOldPenWidth: Integer;

  procedure paintS;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorSi;
        Arc (Left - w div 2, Top - h div 5, Left + w div 2, Top + h div 5,
             Left, Top + h div 5, Left + w div 2, Top);
        Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
             Left + w div 2, Top, Left + w, Top + h div 5);
        Arc (Left, Top + h, Left + w, Top - (h - h div 5),
             Left, Top + h div 5, Left + w, Top + h div 5);
      end;
  end;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorUp;
        Arc (Left - w div 2, Top - h div 5, Left + w div 2, Top + h div 5,
             Left, Top + h div 5, Left + w div 2, Top);
        Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
             Left + w div 2, Top, Left + w, Top + h div 5);
        Pen.Color := colorDn;
        Arc (Left, Top + h, Left + w, Top - (h - h div 5),
             Left, Top + h div 5, Left + w div 2, Top + h);
        Arc (Left,  Top + h, Left + w, Top - (h - h div 5),
             Left + w div 2, Top + h, Left + w, Top + h div 5);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    w := aRect.Right - aRect.Left;
    h := aRect.Bottom - aRect.Top;

    case style of
      rbSingle : paintS;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 begin
                   paintS;
                   InflateRect (aRect, -1, -1);
                   w := aRect.Right - aRect.Left;
                   h := aRect.Bottom - aRect.Top;
                   paintUD;
                 end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1 , -1);
                     w := aRect.Right - aRect.Left;
                     h := aRect.Bottom - aRect.Top;
                     Pen.Color := colorSi;
                     Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
                        Left + w div 2, Top, Left + w, Top + h div 5);
                     Arc (Left,  Top + h, Left + w, Top - (h - h div 5),
                        Left + w div 2, Top + h, Left + w, Top + h div 5);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameSharpShieldRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  w, h : Integer;
  LOldPenWidth: Integer;

  procedure PaintS;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorSi;
        Arc (Left - w, Top - h * 8 div 7, Left + w , Top + h * 8 div 7,
             Left + w div 2, Top + h, Left, Top + h div 5);
        Arc (Left, Top - h * 8 div 7, Left + 2 * w, Top + h * 8 div 7,
             Left, Top + h div 5 , Left + w div 2, Top + h);
        Arc (Left - w div 2, Top - h div 5, Left + w div 2, Top + h div 5,
             Left, Top + h div 5, Left + w div 2, Top);
        Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
             Left + w div 2, Top, Left + w, Top + h div 5);
      end;
  end;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
         Pen.Color := colorUp;
         Arc (Left - w div 2, Top - h div 5, Left + w div 2, Top + h div 5,
              Left, Top + h div 5, Left + w div 2, Top);

         Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
              Left + w div 2, Top, Left + w, Top + h div 5); {JH}

         Pen.Color := colorDn;
         Arc (Left, Top - h * 8 div 7, Left + 2 * w, Top + h * 8 div 7,
              Left, Top + h div 5 , Left + w div 2, Top + h);{JH}
         Arc (Left - w, Top - h * 8 div 7, Left + w , Top + h * 8 div 7,
              Left + w div 2, Top + h, Left, Top + h div 5);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    w := aRect.Right - aRect.Left;
    h := aRect.Bottom - aRect.Top;

    case style of
      rbSingle : paintS;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 begin
                   paintS;
                   InflateRect (aRect, -1, -1);
                   w := aRect.Right - aRect.Left;
                   h := aRect.Bottom - aRect.Top;
                   paintUD;
                 end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1, -1);
                     w := aRect.Right - aRect.Left;
                     h := aRect.Bottom - aRect.Top;
                     Pen.Color := colorSi;
                     Arc (Left - w, Top - h * 8 div 7, Left + w , Top + h * 8 div 7,
                          Left + w div 2, Top + h, Left, Top + h div 5);
                     Arc (Left + w div 2, Top - h div 5, Left + w + w div 2, Top + h div 5,
                          Left + w div 2, Top, Left + w, Top + h div 5);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameEllipticRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  LOldPenWidth: Integer;
begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Ellipse (Left, Top, Right, Bottom);
                   end;
      rbLowered,
      rbRaised : with aRect, aCanvas do
                   begin
                     Pen.Color := colorUp;
                     Arc (Left , Top , Right , Bottom , Right, Top, Left, Bottom);
                     Pen.Color := colorDn;
                     Arc (Left , Top , Right , Bottom , Left, Bottom, Right, Top);
                   end;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Ellipse (Left, Top, Right, Bottom);
                     InflateRect (aRect, -1, -1);
                     Pen.Color := colorUp;
                     Arc (Left , Top , Right , Bottom , Right, Top, Left, Bottom);
                     Pen.Color := colorDn;
                     Arc (Left , Top , Right , Bottom , Left, Bottom, Right, Top);
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     Pen.Color := colorUp;
                     Arc (Left , Top , Right , Bottom , Right, Top, Left, Bottom);
                     Pen.Color := colorDn;
                     Arc (Left , Top , Right , Bottom , Left, Bottom, Right, Top);
                     InflateRect (aRect, -1 , -1);
                     Pen.Color := colorSi;
                     Arc (Left , Top , Right , Bottom , Left, Bottom, Right, Top);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameRoundRectRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; RX, RY : Integer; AFrameWidth: integer = 2);
var
  LOldPenWidth: Integer;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Style := psSolid;
        Pen.Color := colorUp;
        RoundRect (Left, Top, Right, Bottom, RX, RY);
        Pen.Color := colorDn;
        Pen.Width := 4;
        Arc (Left, Bottom - RY, Left + RX, Bottom,
             Left, Bottom, Left + RX div 2, bottom);
        MoveTo (Left + RX div 2, Bottom);
        LineTo (Right - RX div 2, Bottom);
        Arc (Right - RX, Bottom - RY, Right, Bottom,
             Right - RX div 2, Bottom, Right, Bottom - RY div 2);
        MoveTo (Right, Bottom - RY div 2);
        LineTo (Right, Top + RY div 2);
        Arc (Right - RX, Top, Right, Top + RY,
             Right, Top + RY div 2, Right, Top);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    aCanvas.Pen.Style := psSolid;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);

    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     RoundRect (Left, Top, Right, Bottom, RX, RY);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     RoundRect (Left, Top, Right, Bottom, RX, RY);
                     InflateRect (aRect, -1, -1);
                     Right := Right - 2;
                     Bottom := bottom - 2;
                     paintUD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1 , -1);
                     Pen.Color := colorSi;
                     Arc (Left, Bottom - RY, Left + RX, Bottom,
                          Left, Bottom, Left + RX div 2, bottom);
                     MoveTo (Left + RX div 2, Bottom);
                     LineTo (Right - RX div 2, Bottom);
                     Arc (Right - RX, Bottom - RY, Right, Bottom,
                          Right - RX div 2, Bottom, Right, Bottom - RY div 2);
                     MoveTo (Right, Bottom - RY div 2);
                     LineTo (Right, Top + RY div 2);
                     Arc (Right - RX, Top, Right, Top + RY,
                          Right, Top + RY div 2, Right, Top);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameHalfRoundRgn (aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  LOldPenWidth: Integer;

  procedure paintD;
  begin
    with aRect, aCanvas do
      Arc (Left , Top - (Bottom - Top), Right , Bottom , Left, Bottom, Right, Top);
  end;

  procedure paintU;
  begin
    with aRect, aCanvas do
      Arc (Left , Top - (Bottom - Top), Right , Bottom , Right, Top, Left, Bottom);
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Ellipse (Left, Top - (Bottom - Top), Right, Bottom);
                   end;
      rbLowered,
      rbRaised : with aRect, aCanvas do
                   begin
                     Pen.Color := colorUp;
                     paintU;
                     Pen.Color := colorDn;
                     paintD;
                   end;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Ellipse (Left, Top - (Bottom - Top), Right, Bottom);
                     InflateRect (aRect, -1, -1);
                     Pen.Color := colorUp;
                     paintU;
                     Pen.Color := colorDn;
                     paintD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     Pen.Color := colorUp;
                     paintU;
                     Pen.Color := colorDn;
                     paintD;
                     InflateRect (aRect, -1, -1);
                     Pen.Color := colorSi;
                     paintD;
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDFrameRectRgn(aCanvas : TCanvas;aRect : TRect; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  LOldPenWidth: Integer;

  procedure paintUD;
  begin
    with aRect, aCanvas do
      begin
        Pen.Color := colorUp;
        MoveTo (Right, Top);
        LineTo (Left, Top);
        LineTo (Left, Bottom);
        Pen.Color := colorDn;
        MoveTo (Left, Bottom);
        LineTo (Right, Bottom);
        LineTo (Right, Top);
      end;
  end;

begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    case style of
      rbSingle : with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Rect (Left, Top, Right, Bottom);
                   end;
      rbLowered,
      rbRaised : paintUD;
      rbSingleLowered,
      rbSingleRaised :
                 with aRect, aCanvas do
                   begin
                     Pen.Color := colorSi;
                     Rect (Left, Top, Right, Bottom);
                     InflateRect (aRect, -1, -1);
                     paintUD;
                   end;
      rbLoweredpsb,
      rbRaisedpsb :
                 with aRect, aCanvas do
                   begin
                     LMDChangeColors (colorSi, colorDn);
                     paintUD;
                     InflateRect (aRect, -1, -1);
                     Pen.Color := colorSi;
                     MoveTo (Left, Bottom);
                     LineTo (Right, Bottom);
                     LineTo (Right, Top);
                   end;
    end;
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

procedure LMDFramePointList(aCanvas : TCanvas;pl : TLMDPointList; colorUp, colorDn, colorSi : TColor; style : TLMDRegionBorderStyle; AFrameWidth: integer = 2);
var
  i : Integer;
  LOldPenWidth: Integer;
begin
  LOldPenWidth := aCanvas.Pen.Width;
  try
    aCanvas.Pen.Width := AFrameWidth;
    if (pl = nil) or (pl.Count = 0) then exit;
    if style in [rbLowered, rbSingleLowered, rbLoweredpsb] then
      LMDChangeColors (colorUp, colorDn);
    if style = rbSingle then begin colorUp := colorSi; colorDn := colorSi; end;
    aCanvas.Pen.Color := colorUp;
    aCanvas.MoveTo (pl.Points[0].X, pl.Points[0].Y);
    for i := 1 to pl.Count - 1 do
      begin
        if pl.Points[i-1].Y < pl.Points[i].Y then aCanvas.Pen.Color := colorDn;
        if pl.Points[i-1].Y > pl.Points[i].Y then aCanvas.Pen.Color := colorUp;
        if pl.Points[i].X < pl.Points[i-1].X then aCanvas.Pen.Color := colorDn;
        if pl.Points[i].X > pl.Points[i-1].X then aCanvas.Pen.Color := colorUp;

        aCanvas.LineTo (pl.Points[i].X, pl.Points[i].Y);
      end;
    i := pl.Count - 1;
    if pl.Points[i-1].Y < pl.Points[i].Y then aCanvas.Pen.Color := colorDn;
    if pl.Points[i-1].Y > pl.Points[i].Y then aCanvas.Pen.Color := colorUp;
    if pl.Points[i].X < pl.Points[i-1].X then aCanvas.Pen.Color := colorDn;
    if pl.Points[i].X > pl.Points[i-1].X then aCanvas.Pen.Color := colorUp;

    aCanvas.LineTo (pl.Points[0].X, pl.Points[0].Y);
  finally
    aCanvas.Pen.Width := LOldPenWidth;
  end;
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@  TLMDRgnShadow @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------  public ----------------------------------------- }
constructor TLMDRgnShadow.Create;
begin
  inherited Create;
  FStyle := hssNone;
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@  TLMDRegionBorder @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------  private  --------------------------------------- }
procedure TLMDRegionBorder.SetBorderStyle (aValue : TLMDRegionBorderStyle);
begin
  if aValue <> FBorderStyle then
    begin
      FBorderStyle := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionBorder.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionBorder.SetColor (index : integer; aValue : TColor);
begin
  case index of
    0 : if aValue <> FUpColor then
          begin
            FUpColor := aValue;
            GetChange (nil);
          end;
    1 : if aValue <> FDnColor then
          begin
            FDnColor := aValue;
            GetChange (nil);
          end;
    2 : if aValue <> FSiColor then
          begin
            FSiColor := aValue;
            GetChange (nil);
          end;
  end;
end;

{ --------------------------  public  ---------------------------------------- }
constructor TLMDRegionBorder.Create;
begin
  inherited Create;

  FBorderStyle := rbSingle;
  FUpColor     := clBtnHighLight;
  FDnColor     := clBtnShadow;
  FSiColor     := clBlack;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionBorder.Assign (Source : TPersistent);
var
  S: TLMDRegionBorder;
begin
  if Source = self then Exit;
  if Source is TLMDRegionBorder then
    begin
      S := TLMDRegionBorder(Source);
      FBorderStyle := S.Style;
      FUpColor     := S.LightColor;
      FDnColor     := S.ShadowColor;
      FSiColor     := S.SingleColor;
      GetChange (nil);
    end
  else
    inherited Assign (Source);
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@  TLMDRegion @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------  private  --------------------------------------- }
procedure TLMDRegion.SetRegionShape (aValue : TLMDRegionShape);
begin
  if aValue <> FShape then
    begin
      FreeRegion;
      FShape := aValue;
      if FShape = rsPointList then
        GetPointListChange(self);
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetBorder (aValue : TLMDRegionBorder);
begin
  FBorder.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetMask (aValue : TLMDRegionMask);
begin
  FMask.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetInteger (index : Integer; aValue : Integer);
begin
  case index of
    0 : if aValue <> FRoundX then
          begin
            FRoundX := aValue;
            if FShape in [rsRoundRect, rsRoundThinkBubble, rsRoundNoseRect] then
              GetChange (nil);
          end;
    1 : if aValue <> FRoundY then
          begin
            FRoundY := aValue;
            if FShape in [rsRoundRect, rsRoundThinkBubble, rsRoundNoseRect] then
              GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetShadow (aValue : TLMDRgnShadow);
begin
  FShadow.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetNosePos (aValue : TLMDExtPos);
begin
  if aValue <> FNosePos then
    begin
      FNosePos := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDRegion.DeleteHandle (var aValue : HRGN);
begin
  if aValue <> 0 then
    begin
      DeleteObject (aValue);
      aValue := 0;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.GetPointListChange (Sender : TObject);
type
  PPoint = ^TPoint;
var
//  step,
  ap : array of TPoint;//PPoint;
  i : Integer;
  myRgn : HRGN;
begin
  if (FPointList = nil) or (FPointList.Count = 0) then exit;

  SetLength(ap, FPointList.Count);
//  i := FPointList.Count * sizeof (TPoint);
//  GetMem (ap, i);
  if FShape = rsPointList then
    begin
//      ap := VarArrayCreate ([0, FPointList.Count * 2], varVariant);
//      step := ap;
      for i := 0 to FPointList.Count - 1 do
        begin
          ap[i] := FPointList.Points[i];
//          step^ := FPointList.Points[i];
//          inc(step);
        end;

      myRGN := CreatePolygonRgn (ap[0], FPointList.Count, ALTERNATE);

      SetUserRgn (myRGN);
      DeleteObject (myRGN);
    end;
//  FreeMem (ap);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.WriteData (Writer : TWriter);
var
  i : Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FPointList.Count - 1 do
    begin
      Writer.WriteInteger (FPointList.Points[i].X);
      Writer.WriteInteger (FPointList.Points[i].Y);
    enD;
  Writer.WriteListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.ReadData (Reader : TReader);
var
  x, y : Integer;
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin
      x := Reader.ReadInteger;
      y := Reader.ReadInteger;
      FPointList.AddPoint (Point(x, y));
    end;
  Reader.ReadListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineProperty ('PointList', ReadData, WriteData, (FPointList <> nil) and (FPointList.Count <> 0));
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDRegion.Create;
begin
  inherited Create;

  FOwner := nil;

  FShape    := rsRoundRect;
  FRoundX   := 20;
  FRoundY   := 20;

  FNosePos := epLeftTop;

  FBorder      := TLMDRegionBorder.Create;
  FBorder.OnChange := GetChange;
  FMask  := TLMDRegionMask.Create;
  FMask.OnChange := GetChange;
  FBubbleCount := 4;

  FNewHandle := 0;
  FHandleInUse := 0;

  FUserRgnData := nil;
  FUserRgnDataSize := 0;

  FOffsetRgn := Point (0,0);
  FTurnOffShadow := false;

  FShadow := TLMDRgnShadow.Create;
  FShadow.OnChange := GetChange;

  FPointList := TLMDPointList.Create;
  FPointList.OnChange := GetPointListChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDRegion.Destroy;
begin
//FreeRegion;

  if FPointList <> nil then
    begin
      FPointList.OnChange := nil;
      FPointList.Free;
    end;

  if FNewHandle <> 0 then        //remove FNewHandle, used one is FHandleInUse
    DeleteObject (FNewHandle);

//  if FUserRgnData <> nil then
//    FreeMem (FUserRgnData, FUserRgnDataSize);
  FreeRegionData(FUserRgnData);

  FOwner := nil;

  FShadow.OnChange := nil;
  FShadow.Free;

  FMask.OnChange := nil;
  FMask.Free;

  FBorder.OnChange := nil;
  FBorder.Free;

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.Assign (Source : TPersistent);
var
  S: TLMDRegion;
begin
  if Source = self then Exit;
  if Source is TLMDRegion then
    begin
      S := TLMDRegion(Source);
//    FreeRegion;

      FShape     := S.Shape;
      FRoundX    := S.RoundX;
      FRoundY    := S.RoundY;
      FShadow.Assign (S.Shadow);
      FNosePos   := S.ExtPos;
      FBorder.Assign (S.Border);
      FMask.Assign (S.Mask);
      GetChange (nil);
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.CreateRegion (aRect : TRect);

  procedure createARgn (var rgnVal : HRGN);
  begin
    case FShape of
      rsRect:rgnVal := CreateRectRgn(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);

      rsRoundRect:
        rgnVal := CreateRoundRectRgn(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, FRoundX, FRoundY);
        rsBitmap:
          if FMask.RegionDataSize <> 0 then

            rgnVal := ExtCreateRegion (nil, FMask.RegionDataSize, FMask.RegionData^);

        rsStar :
          rgnVal := LMDCreateStarRgn (aRect);
        rsComb :
          rgnVal := LMDCreateCombRgn (aRect);
        rsDiamond :
          rgnVal := LMDCreateDiamondRgn (aRect);
        rsOctagon :
          rgnVal := LMDCreateOctagonRgn (aRect);
        rsElliptic:
          rgnVal := CreateEllipticRgn(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
        rsRoundShield :
          rgnVal := LMDCreateRoundShieldRgn (aRect);
        rsHalfRound :
          rgnVal := CreateEllipticRgn (aRect.Left,  aRect.Top - (aRect.Bottom - aRect.Top), aRect.Right, aRect.Bottom);
        rsSharpShield :
          rgnVal := LMDCreateSharpShieldRgn (aRect);
        rsNoseRect :
          rgnVal := LMDCreateNoseRectRgn (aRect, (aRect.Right - aRect.Left) div 10, FNosePos);
        rsRoundNoseRect :
          rgnVal := LMDCreateRoundNoseRectRgn (aRect, (aRect.Right - aRect.Left) div 10, FRoundX, FRoundY, FNosePos);
        rsThinkBubble :
          rgnVal := LMDCreateThinkBubbleRgn (aRect, (aRect.Right - aRect.Left) div 6, FBubbleCount, FNosePos);
        rsRoundThinkBubble :
          rgnVal := LMDCreateRoundThinkBubbleRgn (aRect, (aRect.Right - aRect.Left) div 6, FBubbleCount, FNosePos, FRoundX, FRoundY);
        rsEllipticThinkBubble :
          rgnVal := LMDCreateEllipticThinkBubbleRgn (aRect, (aRect.Right - aRect.Left) div 6, FBubbleCount, FNosePos);
        rsPointList:
            if FUserRgnDataSize <> 0 then

              rgnVal := ExtCreateRegion (nil, FUserRgnDataSize, FUserRgnData^);

        rsUserRegion :
          if not (csDesigning in Owner.ComponentState) then
            if FUserRgnDataSize <> 0 then

              rgnVal := ExtCreateRegion (nil, FUserRgnDataSize, FUserRgnData^)

            else
              rgnVal := 0
          else
            rgnVal := CreateRectRgn (aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
      end;
    end;

begin

  if (FOwner <> nil) and (csDestroying in FOwner.ComponentState) then
    exit;

  inc (aRect.Left, FOffsetRgn.X);
  inc (aRect.Top, FOffsetRgn.Y);

  if FNewHandle <> 0 then
    begin
      DeleteObject (FNewHandle);
      FNewHandle := 0;
    end;

{  if FShadowHandle <> 0 then
    begin
      DeleteObject (FShadowHandle);
      FShadowHandle := 0;
    end;}

  if FShadow.Style <> hssNone then
  begin
//    InflateRect (aRect, -FShadow.Depth, -FShadow.Depth);
    aRect.Right := aRect.Right - FShadow.Depth;
    aRect.Bottom := aRect.Bottom - FShadow.Depth;
  end;

  createARgn (FNewHandle); // new region in FNewHandle not in FHandleInUse (could be used by the system)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.CreateSpecialRectRgn (const aRect : TRect);
begin
  if (FOwner <> nil) and (csDestroying in FOwner.ComponentState) then
    exit;

  if FNewHandle <> 0 then
    begin
      DeleteObject (FNewHandle);
      FNewHandle := 0;
    end;

  FNewHandle := CreateRectRgnIndirect (aRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetRegion;
var
  helpRgn : HRGN;
begin
  helpRgn := CreateRectRgn (0,0,1,1);
  CombineRgn (helpRgn, FNewHandle, 0, RGN_COPY);
  if (FShadow.Style <> hssNone) and (not FTurnOffShadow) then
    begin
      OffsetRgn (helpRgn, FShadow.Depth, FShadow.Depth);
      CombineRgn (helpRgn, helpRgn, FNewHandle, RGN_OR);
    end
  else
    begin
      //helpRgn := FNewHandle;
    end;

  if FHandleInUse = 0 then                           //CombineRgn will not work on empty regions
    FHandleInUse := CreateRectRgn (0,0,1,1);

  CombineRgn (FHandleInUse, helpRgn, 0, RGN_COPY);  //copy new region to the HandleInUse

  if (FOwner <> nil) and (FOwner.HandleAllocated) and (FHandleInUse <> 0) then
    SetWindowRgn (FOwner.Handle, helpRgn, true);

//  if FShadow.Style <> hssNone then
    DeleteObject (helpRgn)
//  else
//    helpRgn := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.FreeRegion; // used one
begin
  if FHandleInUse <> 0 then
    begin
      //if the region is currently set remove it ...
      if (FOwner <> nil) and (FOwner.HandleAllocated) then
        SetWindowRgn (FOwner.Handle, 0, false);
      if DeleteObject (FHandleInUse) then
        FHandleInUse := 0;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.DrawShadow(aCanvas : TCanvas;var aRect : TRect);
var
  helpRGN : HRGN;
begin
  if (FShadow.Style <> hssNone) then
    begin
      aRect.Right := aRect.Right - FShadow.Depth;
      aRect.Bottom := aRect.Bottom - FShadow.Depth;
    end;

  if (FShadow.Style <> hssNone) and (not FTurnOffShadow) then
    begin
      helpRgn := CreateRectRgn (0,0,1,1);

      CombineRgn (helpRgn, FNewHandle, 0, RGN_COPY);

      OffsetRgn (helpRgn, FShadow.Depth, FShadow.Depth);

      CombineRgn (helpRgn, helpRgn, FNewHandle, RGN_DIFF);

      case FShadow.Style of
        hssSolid:
          begin
            aCanvas.brush.Color:=Shadow.Color;
            aCanvas.pen.Style:=psClear;
          end;
        hssTracing:
          begin
            aCanvas.brush.Bitmap:=LMDApplication.GetBrushBitmap(Shadow.Color);
            aCanvas.pen.Mode:=pmMask;
            aCanvas.pen.Style:=psClear;
          end;
        end;

        FillRgn (aCanvas.Handle, helpRgn, aCanvas.Brush.Handle);
        DeleteObject (helpRgn);
        aCanvas.brush.Style := bsClear;

        aCanvas.Pen.mode := pmCopy;
        aCanvas.Pen.Style := psSolid;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.PaintRegionShape (aCanvas : TCanvas; aRect : TRect);
begin
  inc (aRect.Left, FOffsetRgn.X);
  inc (aRect.Top, FOffsetRgn.Y);

  aCanvas.Brush.Style := bsClear;
  aCanvas.Pen.Width := 2;
  DrawShadow(aCanvas, aRect);
  case FShape of
    rsElliptic :
      LMDFrameEllipticRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsRoundRect :
      LMDFrameRoundRectRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style,
                            FRoundX, FRoundY, FBorder.Width);
    rsStar        :
      LMDFrameStarRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsComb        :
      LMDFrameCombRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsDiamond     :
      LMDFrameDiamondRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsOctagon     :
      LMDFrameOctagonRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsSharpShield :
      LMDFrameSharpShieldRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsRoundShield :
      LMDFrameRoundShieldRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsHalfRound   :
      LMDFrameHalfRoundRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsRect        :
      LMDFrameRectRgn (aCanvas, aRect, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsNoseRect    :
      LMDFrameNoseRectRgn (aCanvas, aRect, (aRect.Right - aRect.Left) div 10, FNosePos, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsRoundNoseRect :
      LMDFrameRoundNoseRectRgn (aCanvas,aRect,(aRect.Right - aRect.Left) div 10,FNosePos, FRoundX, FRoundY, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsThinkBubble :
      LMDFrameThinkBubbleRgn (aCanvas,aRect,(aRect.Right - aRect.Left) div 6, FBubbleCount,FNosePos, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsRoundThinkBubble :
      LMDFrameRoundThinkBubbleRgn (aCanvas,aRect,(aRect.Right - aRect.Left) div 6,FBubbleCount, FNosePos, FRoundX, FRoundY, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsEllipticThinkBubble :
      LMDFrameEllipticThinkBubbleRgn (aCanvas,aRect,(aRect.Right - aRect.Left) div 6, FBubbleCount,FNosePos, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
    rsPointList :
      LMDFramePointList (aCanvas, FPointList, FBorder.LightColor, FBorder.ShadowColor, FBorder.SingleColor, FBorder.Style, FBorder.Width);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetUserRgn (aRGN : HRGN);
begin
  FreeRegionData(FUserRgnData);
  FUserRgnDataSize := GetRegionData(aRGN, 0, nil);
  FUserRgnData := AllocRegionData(FUserRgnDataSize);
  GetRegionData (aRGN, FUserRgnDataSize, FUserRgnData);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegion.SetUserPolygonRgn (const points : array of TPoint);
var
  myRgn : HRGN;
  i : Integer;
begin
  myRgn := CreatePolygonRgn (points, High (points), ALTERNATE);
  try
    FPointList.Clear;
    for i := Low(points) to High(points) do
      FPointList.AddPoint (points[i]);
    SetUserRgn (myRgn);
  finally
    DeleteObject (myRgn);
  end;
end;

end.
