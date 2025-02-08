unit LMDGradientFrames;
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

LMD VCL Series 2010
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdtools.com
SupportSite        : http://www.lmdàsupport.com
Wiki               : http://wiki.lmd.de
BugTracking        : http://bts.lmd.de
Fax                : ++49 69 15347696

################################################################################

LMDGradientFrames unit (VB)
---------------------------

Changes
-------

Release 10.0X (January 2010)
 - Initial Release
###############################################################################}


interface

uses
  Windows, Graphics, Classes, LMDGraph, LMDFigures, LMDFillers;

type
  //Simple frame consists of outer border, inner space and inner border
  TLMDGradientSimpleFramePartKind = (sfpOuterBorder, sfpInnerBorder, sfpInnerSpace);
type
  TLMDGradientSimpleFramePartKinds = set of TLMDGradientSimpleFramePartKind;

type
  //Composite frame consists of outer border, inner space and inner border
  //Each of borders consists of corners and sides
  TLMDGradientComplexFramePartKind = (cfpTopLeftOuterCorner, cfpTopOuterBorder, cfpTopRightOuterCorner,
                     cfpRightOuterBorder, cfpBottomRightOuterCorner, cfpBottomOuterBorder,
                     cfpBottomLeftOuterCorner, cfpLeftOuterBorder,
                     cfpTopLeftInnerCorner, cfpTopInnerBorder, cfpTopRightInnerCorner,
                     cfpRightInnerBorder, cfpBottomRightInnerCorner, cfpBottomInnerBorder,
                     cfpBottomLeftInnerCorner, cfpLeftInnerBorder,
                     cfpSpace,
                     cfpSpaceTopLeftInnerCorner, cfpSpaceTopRightInnerCorner,
                     cfpSpaceBottomRightInnerCorner, cfpSpaceBottomLeftInnerCorner,
                     cfpSpaceTopLeftOuterCorner, cfpSpaceTopRightOuterCorner,
                     cfpSpaceBottomRightOuterCorner, cfpSpaceBottomLeftOuterCorner);
type
  TLMDGradientComplexFramePartKinds = set of TLMDGradientComplexFramePartKind;

const
  cGradientSFrameAllParts = [sfpOuterBorder, sfpInnerBorder, sfpInnerSpace];

  cGradientCFrameAllParts =  [cfpTopLeftOuterCorner, cfpTopOuterBorder, cfpTopRightOuterCorner,
                     cfpRightOuterBorder, cfpBottomRightOuterCorner, cfpBottomOuterBorder,
                     cfpBottomLeftOuterCorner, cfpLeftOuterBorder,
                     cfpTopLeftInnerCorner, cfpTopInnerBorder, cfpTopRightInnerCorner,
                     cfpRightInnerBorder, cfpBottomRightInnerCorner, cfpBottomInnerBorder,
                     cfpBottomLeftInnerCorner, cfpLeftInnerBorder,
                     cfpSpace,
                     cfpSpaceTopLeftInnerCorner, cfpSpaceTopRightInnerCorner,
                     cfpSpaceBottomRightInnerCorner, cfpSpaceBottomLeftInnerCorner,
                     cfpSpaceTopLeftOuterCorner, cfpSpaceTopRightOuterCorner,
                     cfpSpaceBottomRightOuterCorner, cfpSpaceBottomLeftOuterCorner];

  cGradientCFrameOuterBorders = [cfpTopOuterBorder, cfpRightOuterBorder, cfpBottomOuterBorder, cfpLeftOuterBorder];
  GradientCFrameOuterCorners = [cfpTopLeftOuterCorner, cfpTopRightOuterCorner,
                         cfpBottomRightOuterCorner, cfpBottomLeftOuterCorner];
  cGradientCFrameInnerBorders = [cfpTopInnerBorder, cfpRightInnerBorder, cfpBottomInnerBorder, cfpLeftInnerBorder];
  cGradientCFrameInnerCorners = [cfpTopLeftInnerCorner, cfpTopRightInnerCorner,
                         cfpBottomRightInnerCorner, cfpBottomLeftInnerCorner];
  cGradientCompositeFramSpaceInnerCorners = [cfpSpaceTopLeftInnerCorner, cfpSpaceTopRightInnerCorner,
                              cfpSpaceBottomRightInnerCorner, cfpSpaceBottomLeftInnerCorner];
  cGradientCFrameSpaceOuterCorners = [cfpSpaceTopLeftOuterCorner, cfpSpaceTopRightOuterCorner,
                              cfpSpaceBottomRightOuterCorner, cfpSpaceBottomLeftOuterCorner];
  cGradientCFrameSpace = [cfpSpace,
                  cfpSpaceTopLeftInnerCorner, cfpSpaceTopRightInnerCorner,
                  cfpSpaceBottomRightInnerCorner, cfpSpaceBottomLeftInnerCorner,
                  cfpSpaceTopLeftOuterCorner, cfpSpaceTopRightOuterCorner,
                  cfpSpaceBottomRightOuterCorner, cfpSpaceBottomLeftOuterCorner];

type
  TLMDGradientFramePartBase = class(TObject)
  private
    FWidth,
    FEdgeWidth: integer;
    FEdgeColor: TColor;
    FAntiAliasing,
    FSoftEdge: boolean;
    FFiller: TLMDFiller;
  public
    constructor Create; virtual;
    property Width: integer read FWidth write FWidth;
    property EdgeWidth: integer read FEdgeWidth write FEdgeWidth;
    property EdgeColor: TColor read FEdgeColor write FEdgeColor;
    property AntiAliasing: boolean read FAntiAliasing write FAntiAliasing;
    property SoftEdge: boolean read FSoftEdge write FSoftEdge;
    property Filler: TLMDFiller read FFiller write FFiller;
  end;

type
  TLMDGradientRectFramePart = class(TLMDGradientFramePartBase)
  private
    FInnerCutX,
    FInnerCutY,
    FOuterCutX,
    FOuterCutY: integer;
    FInnerCutXValueType,
    FInnerCutYValueType: TLMDValueType;
    FOuterCutXValueType,
    FOuterCutYValueType: TLMDValueType;
    //FOuterCutType,
    //FInnerCutType: TLMDCornerCut;
  public
    OuterCutType: TLMDCornerCut;
    InnerCutType: TLMDCornerCut;

    constructor Create; override;
    property InnerCutX: integer read FInnerCutX write FInnerCutX;
    property InnerCutY: integer read FInnerCutY write FInnerCutY;
    property OuterCutX: integer read FOuterCutX write FOuterCutX;
    property OuterCutY: integer read FOuterCutY write FOuterCutY;
    property InnerCutXValueType: TLMDValueType read FInnerCutXValueType write FInnerCutXValueType;
    property InnerCutYValueType: TLMDValueType read FInnerCutYValueType write FInnerCutYValueType;
    property OuterCutXValueType: TLMDValueType read FOuterCutXValueType write FOuterCutXValueType;
    property OuterCutYValueType: TLMDValueType read FOuterCutYValueType write FOuterCutYValueType;
  end;

type
  TLMDGradientCircleFramePart = class(TLMDGradientFramePartBase)
  private
    FRadius: integer;
    FCenter: TPoint;
  public
    constructor Create; override;
    property Radius: integer read FRadius write FRadius;
    property Center: TPoint read FCenter write FCenter;
  end;


type
  TLMDBaseGradientFrame = class (TObject)
  private
    FOuterBorder: TLMDGradientFramePartBase;
    FInnerSpace:  TLMDGradientFramePartBase;
    FInnerBorder: TLMDGradientFramePartBase;

    FOuterBorderGap,
    FInnerBorderGap: integer;
    FTopSpaceWidth, FRightSpaceWidth, FBottomSpaceWidth, FLeftSpaceWidth: integer;
    FOuterBorderRect,
    FInnerBorderRect: TRect;
    FOuterBorderGapColor,
    FInnerBorderGapColor: TColor;
    FContentsRect: TRect;
    FBoundsRect: TRect;
    FUsePixelFormat: TPixelFormat;

    FVisibleParts: TLMDGradientSimpleFramePartKinds;

    procedure SetOuterBorderGap(const Value: integer);
    procedure SetInnerBorderGap(const Value: integer);
    procedure SetBottomSpaceWidth(const Value: integer);
    procedure SetLeftSpaceWidth(const Value: integer);
    procedure SetRightSpaceWidth(const Value: integer);
    procedure SetTopSpaceWidth(const Value: integer);
  protected
    procedure SetContentsRect(const Value: TRect); virtual;
    property TopSpaceWidth: integer read FTopSpaceWidth write SetTopSpaceWidth;
    property RightSpaceWidth: integer read FRightSpaceWidth write SetRightSpaceWidth;
    property BottomSpaceWidth: integer read FBottomSpaceWidth write SetBottomSpaceWidth;
    property LeftSpaceWidth: integer read FLeftSpaceWidth write SetLeftSpaceWidth;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function CalcBoundsRect(aContentsRect: TRect; aCalcOuterBorderRect: boolean = true): TRect; virtual;
    function CalcContentsRect(aBoundsRect: TRect): TRect; virtual;
    function CalcInnerBorderRect(aContentsRect: TRect): TRect; virtual;
    function CalcOuterBorderRect(aContentsRect: TRect; aCalcInnerBorderRect: boolean = true): TRect; virtual;

    procedure Draw(aTargetBmp: TBitmap; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit); overload; virtual; abstract;
    procedure Draw(aTargetCanvas: TCanvas; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit); overload; virtual;
    procedure Draw(aTargetDC: HDC; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit); overload; virtual;

    procedure DrawOuterBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); virtual; abstract;
    procedure DrawInnerBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); virtual; abstract;
    procedure DrawInnerSpace(aTargetBmp: TBitmap; aFiller: TLMDFiller); virtual; abstract;

    property OuterBorderRect: TRect read FOuterBorderRect;
    property InnerBorderRect: TRect read FInnerBorderRect;
    property OuterBorderGapColor: TColor read FOuterBorderGapColor write FOuterBorderGapColor;
    property InnerBorderGapColor: TColor read FInnerBorderGapColor write FInnerBorderGapColor;
    property ContentsRect: TRect read FContentsRect write SetContentsRect;
    property BoundsRect: TRect read FBoundsRect;
    property OuterBorderGap: integer read FOuterBorderGap write SetOuterBorderGap;
    property InnerBorderGap: integer read FInnerBorderGap write SetInnerBorderGap;
    property UsePixelFormat: TPixelFormat read FUsePixelFormat write FUsePixelFormat;
    property VisibleParts: TLMDGradientSimpleFramePartKinds read FVisibleParts write FVisibleParts;

    property OuterBorder: TLMDGradientFramePartBase read FOuterBorder;
    property InnerSpace:  TLMDGradientFramePartBase read FInnerSpace;
    property InnerBorder: TLMDGradientFramePartBase read FInnerBorder;
  end;


type
  TLMDGradientRectFrame = class (TLMDBaseGradientFrame)
  private
    FVisibleParts: TLMDGradientSimpleFramePartKinds;
    FCutValueUsage: TLMDCutValueUsage;
    FOuterBorderSides: TLMDFrameSides;
    FInnerBorderSides: TLMDFrameSides;
    function GetInnerBorder: TLMDGradientRectFramePart;
    function GetInnerSpace: TLMDGradientRectFramePart;
    function GetOuterBorder: TLMDGradientRectFramePart;
  protected
    procedure DrawMainFigure(aTargetBmp: TBitmap; R1,
      R2: TRect; aFrameSides: TLMDFrameSides; aEdgeWidth: integer; aEdgeColor: TColor;
      aOuterCornerCutType, aInnerCornerCutType: TLMDCornerCut;
      aCutX1, aCutY1, aCutX2, aCutY2: integer;
      aCutXVType1, aCutYVType1,
      aCutXVType2, aCutYVType2: TLMDValueType; aFiller: TLMDFiller;
      aPixelFormat: TPixelFormat; aAntiAliasing: boolean = true; aSoftEdge: boolean = false); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Draw(aTargetBmp: TBitmap; aDestRect: TRect; aPixelFormat: TPixelFormat {= pf24bit}); overload; override;
    procedure DrawOuterBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawInnerBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawInnerSpace(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;

    property TopSpaceWidth;
    property RightSpaceWidth;
    property BottomSpaceWidth;
    property LeftSpaceWidth;

    property CutValueUsage: TLMDCutValueUsage read FCutValueUsage write FCutValueUsage default cvuXOnly;
    property VisibleParts: TLMDGradientSimpleFramePartKinds read FVisibleParts write FVisibleParts;
    property OuterBorderSides: TLMDFrameSides read FOuterBorderSides write FOuterBorderSides;
    property InnerBorderSides: TLMDFrameSides read FInnerBorderSides write FInnerBorderSides;

    property OuterBorder: TLMDGradientRectFramePart read GetOuterBorder;
    property InnerSpace: TLMDGradientRectFramePart read GetInnerSpace;
    property InnerBorder: TLMDGradientRectFramePart read GetInnerBorder;
  end;


type
  TLMDGradientCircleFrame = class (TLMDBaseGradientFrame)
  private
    FContentsRadius: integer;
    FContentsCenter: TPoint;
    FVisibleParts: TLMDGradientSimpleFramePartKinds;
    function GetSpaceWidth: integer;
    procedure SetSpaceWidth(const Value: integer);
    procedure SetContentsRadius(const Value: integer);
    function GetInnerBorder: TLMDGradientCircleFramePart;
    function GetInnerSpace: TLMDGradientCircleFramePart;
    function GetOuterBorder: TLMDGradientCircleFramePart;
  protected
    procedure SetContentsRect(const Value: TRect); override;
    procedure DrawMainFigure(aTargetBmp: TBitmap; aCenter1, aCenter2: TPoint; aRadius1, aRadius2: integer;
      aEdgeWidth: integer; aEdgeColor: TColor;
      aFiller: TLMDFiller;
      aPixelFormat: TPixelFormat; aAntiAliasing: boolean = true; aSoftEdge: boolean = false); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    function CalcBoundsRect(aContentsRect: TRect; aCalcOuterBorderRect: boolean = true): TRect; override;
    procedure Draw(aTargetBmp: TBitmap; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit); overload; override;
    procedure DrawOuterBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawInnerBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawInnerSpace(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;

    property VisibleParts: TLMDGradientSimpleFramePartKinds read FVisibleParts write FVisibleParts;
    property SpaceWidth: integer read GetSpaceWidth write SetSpaceWidth;
    property ContentsCenter: TPoint read FContentsCenter;

    property ContentsRadius: integer read FContentsRadius write SetContentsRadius;

    property OuterBorder: TLMDGradientCircleFramePart read GetOuterBorder;
    property InnerSpace: TLMDGradientCircleFramePart read GetInnerSpace;
    property InnerBorder: TLMDGradientCircleFramePart read GetInnerBorder;
  end;


type
  TLMDModifyGradientCFrameFillerFunc = function (aFramePart: TLMDGradientComplexFramePartKind; var aFiller: TLMDFiller): boolean;

type
  TLMDGradientComplexFrame = class (TLMDBaseGradientFrame)
  private
    FVisibleParts: TLMDGradientComplexFramePartKinds;
    FCutType: array[TLMDGradientComplexFramePartKind] of TLMDCutType;
    FModifyFillerFunc: TLMDModifyGradientCFrameFillerFunc;
    FInnerSpaceOuterCornersColor: TColor;
    FInnerSpaceOuterCornersAlpha: byte;
    FOuterCornersFiller,
    FInnerCornersFiller: TLMDFiller;
    function GetInnerBorder: TLMDGradientRectFramePart;
    function GetInnerSpace: TLMDGradientRectFramePart;
    function GetOuterBorder: TLMDGradientRectFramePart;

    //function GetCutType(Index: TLMDGradientComplexFramePartKind): TLMDCutType;
    //procedure SetCutType(Index: TLMDGradientComplexFramePartKind;
    //  const Value: TLMDCutType);
  protected
    function ModifyFiller(aFramePart: TLMDGradientComplexFramePartKind; var aFiller: TLMDFiller):boolean; virtual;
  public
    //CutType: array[TLMDGradientComplexFramePartKind] of TLMDCutType;
    constructor Create; override;
    procedure Draw(aTargetBmp: TBitmap; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit); overload; override;
    procedure DrawOuterBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawInnerBorder(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;
    procedure DrawOuterCorners(aTargetBmp: TBitmap; aFiller: TLMDFiller); virtual;
    procedure DrawInnerCorners(aTargetBmp: TBitmap; aFiller: TLMDFiller); virtual;
    procedure DrawInnerSpace(aTargetBmp: TBitmap; aFiller: TLMDFiller); override;

    property ModifyFillerFunc: TLMDModifyGradientCFrameFillerFunc read FModifyFillerFunc write FModifyFillerFunc;
    property OuterCornersFiller: TLMDFiller read FOuterCornersFiller write FOuterCornersFiller;
    property InnerCornersFiller: TLMDFiller read FInnerCornersFiller write FInnerCornersFiller;

    property TopSpaceWidth;
    property RightSpaceWidth;
    property BottomSpaceWidth;
    property LeftSpaceWidth;

    property VisibleParts: TLMDGradientComplexFramePartKinds read FVisibleParts write FVisibleParts;

    property OuterBorder: TLMDGradientRectFramePart read GetOuterBorder;
    property InnerSpace: TLMDGradientRectFramePart read GetInnerSpace;
    property InnerBorder: TLMDGradientRectFramePart read GetInnerBorder;
  end;


implementation

uses
  LMDGraphUtils, LMDProcs, Math, SysUtils;

{-------------------- TLMDBaseGradientFrame -----------------------------------}

constructor TLMDBaseGradientFrame.Create;
begin
  FUsePixelFormat := pf24bit;
  FOuterBorderGapColor := clWhite;
  FInnerBorderGapColor := clWhite;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.Draw(aTargetCanvas: TCanvas; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit);
var
  bmp: TBitmap;
  sbr, br, r: TRect;
begin
  FUsePixelFormat := aPixelFormat;
  sbr := CalcBoundsRect(aDestRect);
  r := aDestRect;
  br := sbr;
  OffsetRect(br, -sbr.Left, -sbr.Top);
  OffsetRect(r, -sbr.Left, -sbr.Top);

  Bmp := TBitmap.Create;
  Bmp.PixelFormat := FUsePixelFormat;
  {$IFDEF LMDCOMP12}
  if FUsePixelFormat = pf32bit then
    Bmp.AlphaFormat := afDefined;
  {$ENDIF}

  Bmp.Width := br.Right - br.Left + 1;
  Bmp.Height := br.Bottom - br.Top + 1;
  BitBlt(bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, aTargetCanvas.Handle, sbr.Left, sbr.Top, SRCCOPY);
  Draw(Bmp, r, FUsePixelFormat);
  aTargetCanvas.Draw(sbr.Left, sbr.Top, Bmp); //TODO: check if bitblt here is better VB
  Bmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.Draw(aTargetDC: HDC; aDestRect: TRect; aPixelFormat: TPixelFormat);
var
  bmp: TBitmap;
  sbr, br, r: TRect;
begin
  FUsePixelFormat := aPixelFormat;
  sbr := CalcBoundsRect(aDestRect);
  r := aDestRect;
  br := sbr;
  OffsetRect(br, -sbr.Left, -sbr.Top);
  OffsetRect(r, -sbr.Left, -sbr.Top);

  Bmp := TBitmap.Create;
  Bmp.PixelFormat := FUsePixelFormat;
  {$IFDEF LMDCOMP12}
  if FUsePixelFormat = pf32bit then
    Bmp.AlphaFormat := afDefined;
  {$ENDIF}

  Bmp.Width := br.Right - br.Left + 1;
  Bmp.Height := br.Bottom - br.Top + 1;
  BitBlt(bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, aTargetDC, sbr.Left, sbr.Top, SRCCOPY);
  Draw(Bmp, r, FUsePixelFormat);
  BitBlt(aTargetDC, sbr.Left, sbr.Top, Bmp.Width, Bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
  Bmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetOuterBorderGap(const Value: integer);
begin
  FOuterBorderGap := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetInnerBorderGap(const Value: integer);
begin
  FInnerBorderGap := Value;
end;


{ ---------------------------------------------------------------------------- }
function TLMDBaseGradientFrame.CalcBoundsRect(aContentsRect: TRect;
  aCalcOuterBorderRect: boolean): TRect;
var
  r: TRect;
begin
  if aCalcOuterBorderRect then
    r := CalcOuterBorderRect(aContentsRect)
  else
    r := FOuterBorderRect;
  InflateRect(r, {OuterBorder.EdgeWidth +} FOuterBorder.Width - 1, {OuterBorder.EdgeWidth +} FOuterBorder.Width - 1);
  result := r;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGradientFrame.CalcContentsRect(aBoundsRect: TRect): TRect;
begin
  result := aBoundsRect;
  InflateRect(result, 1 - FOuterBorder.Width {- OuterBorder.EdgeWidth} - FOuterBorderGap, 1 - FOuterBorder.Width - {OuterBorder.EdgeWidth -} FOuterBorderGap);
  with result do
    begin
      Top := Top + FTopSpaceWidth;
      Right := Right - FRightSpaceWidth;
      Bottom := Bottom - FBottomSpaceWidth;
      Left := Left + FLeftSpaceWidth ;
    end;
  InflateRect(result, -1, -1);
  InflateRect(result, -FInnerBorder.Width - {InnerBorder.EdgeWidth -} InnerBorderGap, - FInnerBorder.Width {- InnerBorder.EdgeWidth} - InnerBorderGap);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGradientFrame.CalcInnerBorderRect(
  aContentsRect: TRect): TRect;
begin
  result := aContentsRect;
  InflateRect(result, FInnerBorder.Width + {InnerBorder.EdgeWidth +} InnerBorderGap, FInnerBorder.Width + {InnerBorder.EdgeWidth +} InnerBorderGap);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseGradientFrame.CalcOuterBorderRect(aContentsRect: TRect;
  aCalcInnerBorderRect: boolean): TRect;
var
  r: TRect;
begin
  if aCalcInnerBorderRect then
    r := CalcInnerBorderRect(aContentsRect)
  else
    r := InnerBorderRect;
  with result do
    begin
      Top := r.Top - FTopSpaceWidth - OuterBorderGap;
      Right := r.Right + FRightSpaceWidth + OuterBorderGap;
      Bottom := r.Bottom + FBottomSpaceWidth + OuterBorderGap;
      Left := r.Left - FLeftSpaceWidth - OuterBorderGap;
    end;
  InflateRect(result, 1, 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetContentsRect(const Value: TRect);
begin
  FContentsRect := Value;
  FInnerBorderRect := CalcInnerBorderRect(FContentsRect);
  FOuterBorderRect := CalcOuterBorderRect(FContentsRect, false);
  FBoundsRect := CalcBoundsRect(FContentsRect, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetBottomSpaceWidth(const Value: integer);
begin
  FBottomSpaceWidth := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetLeftSpaceWidth(const Value: integer);
begin
  FLeftSpaceWidth := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetRightSpaceWidth(const Value: integer);
begin
  FRightSpaceWidth := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseGradientFrame.SetTopSpaceWidth(const Value: integer);
begin
  FTopSpaceWidth := Value;
end;

{--------------------------- TLMDGradientRectFrame ----------------------------}
constructor TLMDGradientRectFrame.Create;
begin
  inherited;

  FOuterBorder := TLMDGradientRectFramePart.Create;
  FInnerBorder := TLMDGradientRectFramePart.Create;
  FInnerSpace :=  TLMDGradientRectFramePart.Create;

  OuterBorderSides := [fsBottom, fsLeft, fsRight, fsTop];
  InnerBorderSides := [fsBottom, fsLeft, fsRight, fsTop];  

  with OuterBorder do
    begin
      InnerCutXValueType := vtPercent;
      InnerCutYValueType := vtPercent;
      OuterCutXValueType := vtPercent;
      OuterCutYValueType := vtPercent;
      OuterCutX := 15;
      OuterCutY := 15;
      InnerCutX := 13;
      InnerCutY := 13;
    end;

  with InnerBorder do
    begin
      InnerCutXValueType := vtPercent;
      InnerCutYValueType := vtPercent;
      OuterCutXValueType := vtPercent;
      OuterCutYValueType := vtPercent;
      OuterCutX := 11;
      OuterCutY := 11;
      InnerCutX := 10;
      InnerCutY := 10;
    end;

  with InnerSpace do
    begin
      InnerCutXValueType := vtPercent;
      InnerCutYValueType := vtPercent;
      OuterCutXValueType := vtPercent;
      OuterCutYValueType := vtPercent;
      OuterCutX := 13;
      OuterCutY := 13;
      InnerCutX := 11;
      InnerCutY := 11;
    end;

  VisibleParts := [sfpOuterBorder, sfpInnerBorder, sfpInnerSpace];
  CutValueUsage := cvuXOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientRectFrame.DrawMainFigure(aTargetBmp: TBitmap; R1,
  R2: TRect; aFrameSides: TLMDFrameSides;
  aEdgeWidth: integer; aEdgeColor: TColor;
  aOuterCornerCutType, aInnerCornerCutType: TLMDCornerCut;
  aCutX1, aCutY1, aCutX2, aCutY2: integer;
  aCutXVType1, aCutYVType1,
  aCutXVType2, aCutYVType2: TLMDValueType; aFiller: TLMDFiller;
  aPixelFormat: TPixelFormat; aAntiAliasing: boolean = true; aSoftEdge: boolean = false);
var
  lsf: TLMDSubtractionFigure;
  i, cx, cy: integer;
  rc: TLMDRectangleCorner;
  lctarr: array[0..1] of TLMDCornerCut;
  lrarr: array[0..1] of TRect;
  lcutx, lcuty: array [0..1] of integer;
  lcxvtype, lcyvtype: array[0..1] of TLMDValueType;
begin
  if aFiller = nil then
    exit;

  lsf := TLMDSubtractionFigure.Create;
  lsf.Add(TLMDCustomCutRectangle.Create);
  lsf.Add(TLMDCustomCutRectangle.Create);

  lctarr[0] := aOuterCornerCutType;
  lctarr[1] := aInnerCornerCutType;
  lrarr[0] := R1;
  lrarr[1] := R2;
  lcutx[0] := aCutX1;
  lcutx[1] := aCutX2;
  lcuty[0] := aCutY1;
  lcuty[1] := aCutY2;
  lcxvtype[0] := aCutXVType1;
  lcxvtype[1] := aCutXVType2;
  lcyvtype[0] := aCutYVType1;
  lcyvtype[1] := aCutYVType2;
  with lsf do
    begin
      //Initialize
      Transparent := false;
      AntiAliasing := aAntiAliasing;
      SoftBorder := aSoftEdge;
      BorderWidth := aEdgeWidth;
      BorderColor := aEdgeColor;

      if not(fsLeft in aFrameSides) then
        r2.Left := r1.Left;
      if not(fsRight in aFrameSides) then
        r2.Right := r1.Right;
      if not(fsTop in aFrameSides) then
        r2.Top := r1.Top;
      if not(fsBottom in aFrameSides) then
        r2.Bottom := r1.Bottom;

      TLMDCustomCutRectangle(Item[0]).Rectangle(r1);
      TLMDCustomCutRectangle(Item[1]).Rectangle(r2);

      for i := 0 to lsf.Count - 1 do
        with TLMDCustomCutRectangle(lsf.Item[i]) do
          begin
            LMDCalcCutValues(cx, cy, lcutx[i], lcuty[i], lcxvtype[i], lcyvtype[i], CutValueUsage, lrarr[i]);
            CutX := cx;
            CutY := cy;
          end;
      for i := 0 to lsf.Count - 1 do
        with TLMDCustomCutRectangle(lsf.Item[i]) do
          for rc := low(TLMDRectangleCorner) to high(TLMDRectangleCorner) do
            if (TLMDCustomCutRectangle(lsf.Item[i]).CutX <= 0) or (TLMDCustomCutRectangle(lsf.Item[i]).CutY <= 0) then
              CornerCut[rc] := ctNone
            else
              CornerCut[rc] := lctarr[i, rc];

      Filler := aFiller;

      //Draw
      Draw(aTargetBmp, FUsePixelFormat);
    end;
  lsf.Clear(true);  
  lsf.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientRectFrame.Draw(aTargetBmp: TBitmap; aDestRect: TRect;
  aPixelFormat: TPixelFormat);
begin
  FUsePixelFormat := aPixelFormat;
  ContentsRect := aDestRect;
  DrawInnerSpace(aTargetBmp, InnerSpace.Filler);
  DrawInnerBorder(aTargetBmp, InnerBorder.Filler);
  DrawOuterBorder(aTargetBmp, OuterBorder.Filler);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientRectFrame.DrawOuterBorder(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
var
  R1, R2: TRect;
begin
  if (OuterBorder.Width <= 0) or not (sfpOuterBorder in VisibleParts) then
    exit;
  r1 := OuterBorderRect;
  InflateRect(r1, -1, -1);
  InflateRect(r1, OuterBorder.Width {- OuterBorder.EdgeWidth},  OuterBorder.Width {- OuterBorder.EdgeWidth});
  r2 := OuterBorderRect;
  InflateRect(r2, -1, -1);
  with OuterBorder do
    DrawMainFigure(aTargetBmp, R1, R2, OuterBorderSides,
      EdgeWidth, EdgeColor, OuterCutType,
      InnerCutType, OuterCutX, OuterCutY, InnerCutX, InnerCutY,
      OuterCutXValueType, OuterCutYValueType,
      InnerCutXValueType, InnerCutYValueType,
      aFiller, UsePixelFormat, AntiAliasing, SoftEdge );
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientRectFrame.DrawInnerBorder(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
var
  R1, R2: TRect;
begin
  if (InnerBorder.Width <= 0) or not (sfpInnerBorder in VisibleParts) then
    exit;

  R1 := InnerBorderRect;
  InflateRect(R1, -InnerBorderGap, -InnerBorderGap);
  R2 := R1;
  InflateRect(R2, -InnerBorder.Width {+ InnerBorder.EdgeWidth}, -InnerBorder.Width {+ InnerBorder.EdgeWidth});

  with InnerBorder do
    DrawMainFigure(aTargetBmp, R1, R2, InnerBorderSides,
      EdgeWidth, EdgeColor, OuterCutType,
      InnerCutType, OuterCutX, OuterCutY, InnerCutX, InnerCutY,
      OuterCutXValueType, OuterCutYValueType,
      InnerCutXValueType, InnerCutYValueType,
      aFiller, UsePixelFormat, AntiAliasing, SoftEdge);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientRectFrame.DrawInnerSpace(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
var
  R1, R2,
  Ro1, Ro2, Ri1, Ri2: TRect;
  lFiller : TLMDSolidFiller;
begin
  R1 := OuterBorderRect;
  Ro1 := R1;
  InflateRect(R1, -1, -1);
  InflateRect(R1, -OuterBorderGap, -OuterBorderGap);
  R2 := R1;
  Ro2 := R2;

  with R2 do
    begin
      Top := Top + FTopSpaceWidth;
      Right := Right - FRightSpaceWidth;
      Bottom := Bottom - FBottomSpaceWidth;
      Left := Left + FLeftSpaceWidth ;
    end;

  Ri1 := R2;
  Ri2 := R2;
  InflateRect(Ri2, -InnerBorderGap, -InnerBorderGap);

  lFiller := nil;
  if (InnerBorderGap > 0) or (OuterBorderGap > 0) then
    begin
      lFiller := TLMDSolidFiller.Create;
      if (OuterBorderGap > 0) then
        begin
          //fill outer border gap
          lFiller.Color := OuterBorderGapColor;
          DrawMainFigure(aTargetBmp, Ro1, Ro2, AllFrameSides,
            0, clNone, OuterBorder.InnerCutType, InnerSpace.OuterCutType,
            OuterBorder.InnerCutX, OuterBorder.InnerCutY, InnerSpace.OuterCutX, InnerSpace.OuterCutY,
            OuterBorder.InnerCutXValueType, OuterBorder.InnerCutYValueType,
            InnerSpace.OuterCutXValueType, InnerSpace.OuterCutYValueType,
            lFiller, UsePixelFormat, InnerSpace.AntiAliasing, InnerSpace.SoftEdge);
        end;
      if (InnerBorderGap > 0) then
        begin
          //fill inner border gap
          lFiller.Color := InnerBorderGapColor;
          DrawMainFigure(aTargetBmp, Ri1, Ri2, AllFrameSides,
            0, clNone, InnerSpace.InnerCutType, InnerBorder.OuterCutType,
            InnerSpace.InnerCutX, InnerSpace.InnerCutY, InnerBorder.OuterCutX, InnerBorder.OuterCutY,
            InnerSpace.InnerCutXValueType, InnerSpace.InnerCutYValueType,
            InnerBorder.OuterCutXValueType, InnerBorder.OuterCutYValueType,
            lFiller, UsePixelFormat, InnerSpace.AntiAliasing, InnerSpace.SoftEdge);
        end;
    end;

  if ((LeftSpaceWidth<>0) or (TopSpaceWidth<>0) or (RightSpaceWidth<>0)
    or (BottomSpaceWidth<>0)) and (sfpInnerSpace in VisibleParts) then
    begin
      //fill inner space
      with InnerSpace do
        DrawMainFigure(aTargetBmp, R1, R2, AllFrameSides,
          EdgeWidth, EdgeColor, OuterCutType,
          InnerCutType, OuterCutX, OuterCutY, InnerCutX, InnerCutY,
          OuterCutXValueType, OuterCutYValueType,
          InnerCutXValueType, InnerCutYValueType,
          aFiller, UsePixelFormat, AntiAliasing, SoftEdge);
     end;

  if lFiller <> nil then
    lFiller.Free;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDGradientRectFrame.Destroy;
begin
  FreeAndNil(FOuterBorder);
  FreeAndNil(FInnerBorder);
  FreeAndNil(FInnerSpace);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientRectFrame.GetInnerBorder: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FInnerBorder);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientRectFrame.GetInnerSpace: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FInnerSpace);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientRectFrame.GetOuterBorder: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FOuterBorder);
end;

{------------------------ TLMDGradientCircleFrame -----------------------------}
function TLMDGradientCircleFrame.CalcBoundsRect(aContentsRect: TRect;
  aCalcOuterBorderRect: boolean): TRect;
begin
  result := inherited CalcBoundsRect(aContentsRect, aCalcOuterBorderRect);
  //InflateRect(result, 1, 1);
end;

constructor TLMDGradientCircleFrame.Create;
begin
  inherited;
  FOuterBorder := TLMDGradientCircleFramePart.Create;
  FInnerSpace := TLMDGradientCircleFramePart.Create;
  FInnerBorder := TLMDGradientCircleFramePart.Create;
  VisibleParts := [sfpOuterBorder, sfpInnerBorder, sfpInnerSpace];
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDGradientCircleFrame.Destroy;
begin
  FreeAndNil(FOuterBorder);
  FreeAndNil(FInnerBorder);
  FreeAndNil(FInnerSpace);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.Draw(aTargetBmp: TBitmap;
  aDestRect: TRect; aPixelFormat: TPixelFormat);
begin
  FUsePixelFormat := aPixelFormat;
  ContentsRect := aDestRect;
  DrawInnerSpace(aTargetBmp, InnerSpace.Filler);
  DrawInnerBorder(aTargetBmp, InnerBorder.Filler);
  DrawOuterBorder(aTargetBmp, OuterBorder.Filler);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.DrawInnerBorder(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
begin
  if sfpInnerBorder in VisibleParts then
    with InnerBorder do
      DrawMainFigure(aTargetBmp, Center, ContentsCenter, Radius, Radius - Width,
        EdgeWidth, EdgeColor, Filler, UsePixelFormat, AntiAliasing, SoftEdge);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.DrawInnerSpace(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
var
  R1, R2: integer;
  lFiller : TLMDSolidFiller;
begin
  lFiller := nil;
  if (InnerBorderGap > 0) or (OuterBorderGap > 0) then
    begin
      lFiller := TLMDSolidFiller.Create;
      if (OuterBorderGap > 0) then
        begin
          //fill outer border gap
          lFiller.Color := OuterBorderGapColor;
          R1 := OuterBorder.Radius;
          R2 := OuterBorder.Radius - OuterBorderGap;
          DrawMainFigure(aTargetBmp, OuterBorder.Center, OuterBorder.Center, R1, R2,
            InnerBorder.EdgeWidth, InnerBorder.EdgeColor, lFiller, UsePixelFormat, InnerSpace.AntiAliasing, InnerSpace.SoftEdge);
        end;
      if (InnerBorderGap > 0) then
        begin
          //fill inner border gap
          R1 := InnerBorder.Radius + InnerBorderGap;
          R2 := InnerBorder.Radius;
          lFiller.Color := InnerBorderGapColor;
          DrawMainFigure(aTargetBmp, InnerBorder.Center, InnerBorder.Center, R1, R2,
            InnerBorder.EdgeWidth, InnerBorder.EdgeColor, lFiller, UsePixelFormat, InnerSpace.AntiAliasing, InnerSpace.SoftEdge);
        end;
    end;

  if (SpaceWidth<>0) and (sfpInnerSpace in VisibleParts) then
    //fill inner space
    DrawMainFigure(aTargetBmp, InnerSpace.Center, InnerBorder.Center, OuterBorder.Radius - OuterBorderGap, InnerBorder.Radius + InnerBorderGap,
       InnerBorder.EdgeWidth, InnerBorder.EdgeColor, InnerSpace.Filler, UsePixelFormat, InnerSpace.AntiAliasing, InnerSpace.SoftEdge);

  if lFiller <> nil then
    lFiller.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.DrawMainFigure(aTargetBmp: TBitmap;
  aCenter1, aCenter2: TPoint; aRadius1, aRadius2, aEdgeWidth: integer; aEdgeColor: TColor;
  aFiller: TLMDFiller; aPixelFormat: TPixelFormat; aAntiAliasing: boolean = true; aSoftEdge: boolean = false);
var
  lsf: TLMDSubtractionFigure;
begin
  if aFiller = nil then
    exit;

  lsf := TLMDSubtractionFigure.Create;
  lsf.Add(TLMDCircle.Create);
  lsf.Add(TLMDCircle.Create);

  with lsf do
    begin
      //Initialize
      Transparent := false;
      AntiAliasing := aAntiAliasing;
      SoftBorder := aSoftEdge;
      BorderWidth := aEdgeWidth;
      BorderColor := aEdgeColor;
      TLMDCircle(Item[0]).Center := aCenter1;
      TLMDCircle(Item[1]).Center := aCenter2;
      TLMDCircle(Item[0]).Radius := aRadius1;
      TLMDCircle(Item[1]).Radius := aRadius2;
      Filler := aFiller;
      //Draw
      Draw(aTargetBmp, FUsePixelFormat);
    end;
  lsf.Clear(true);
  lsf.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.DrawOuterBorder(aTargetBmp: TBitmap;
  aFiller: TLMDFiller);
begin
  if sfpOuterBorder in VisibleParts then
    with OuterBorder do
      DrawMainFigure(aTargetBmp, Center, InnerSpace.Center, Radius + Width, Radius,
        EdgeWidth, EdgeColor, Filler, UsePixelFormat, AntiAliasing, SoftEdge);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientCircleFrame.GetInnerBorder: TLMDGradientCircleFramePart;
begin
  result := TLMDGradientCircleFramePart(FInnerBorder);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientCircleFrame.GetInnerSpace: TLMDGradientCircleFramePart;
begin
  result := TLMDGradientCircleFramePart(FInnerSpace);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientCircleFrame.GetOuterBorder: TLMDGradientCircleFramePart;
begin
  result := TLMDGradientCircleFramePart(FOuterBorder);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientCircleFrame.GetSpaceWidth: integer;
begin
  result := 2*FTopSpaceWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.SetContentsRadius(const Value: integer);
var
  r: TRect;
begin
  FContentsRadius := Value;
  with ContentsCenter do
    r := Rect(x - FContentsRadius, y - FContentsRadius, x + FContentsRadius, y + FContentsRadius);
  ContentsRect := r;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.SetContentsRect(const Value: TRect);
begin
  inherited;
  FContentsCenter := LMDMiddlePoint(Value.TopLeft, Value.BottomRight);
  FContentsRadius := FContentsCenter.X - ContentsRect.Left;

  InnerBorder.Center := LMDMiddlePoint(InnerBorderRect.TopLeft, InnerBorderRect.BottomRight);
  InnerBorder.Radius := InnerBorder.Center.X - InnerBorderRect.Left;

  OuterBorder.Center := LMDMiddlePoint(OuterBorderRect.TopLeft, OuterBorderRect.BottomRight);
  OuterBorder.Radius := OuterBorder.Center.X - OuterBorderRect.Left - 1;

  InnerSpace.Center := LMDMiddlePoint(InnerBorderRect.TopLeft, InnerBorderRect.BottomRight);
  InnerSpace.Radius := InnerBorder.Radius + InnerBorderGap + InnerBorder.Width + SpaceWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientCircleFrame.SetSpaceWidth(const Value: integer);
begin
  FTopSpaceWidth := Value;
  FRightSpaceWidth := Value;
  FBottomSpaceWidth := Value;
  FLeftSpaceWidth := Value;
end;

{-------------------------- TLMDGradientComplexFrame -------------------------}
procedure TLMDGradientComplexFrame.Draw(aTargetBmp: TBitmap; aDestRect: TRect; aPixelFormat: TPixelFormat = pf24bit);
begin
  FUsePixelFormat := aPixelFormat;
  ContentsRect := aDestRect;
  DrawOuterBorder(aTargetBmp, FOuterBorder.Filler);
  DrawOuterCorners(aTargetBmp, FOuterCornersFiller);
  DrawInnerBorder(aTargetBmp, FInnerBorder.Filler);
  DrawInnerCorners(aTargetBmp, FInnerCornersFiller);
  DrawInnerSpace(aTargetBmp, FInnerSpace.Filler);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientComplexFrame.DrawInnerBorder(aTargetBmp :TBitmap; aFiller: TLMDFiller);
var
  lf: TLMDLine;
  R: TRect;
  d, x, y: integer;
begin
  if (InnerBorder.Width <= 0) or (cGradientCFrameInnerBorders*VisibleParts=[]) then
    exit;
  R := InnerBorderRect;
  InflateRect(R, -InnerBorderGap, -InnerBorderGap);
  lf := TLMDLine.Create(0,0,0,0,0);

  with lf do
    begin
      //Initialize
      BorderSides := [];
      Transparent := false;
      AntiAliasing := true;
      SoftBorder := false;
      BorderColor := clNone;
      BorderWidth := 0;
      Filler := aFiller;

      x := (R.Left+R.Right) div 2;
      y := (R.Top + R.Bottom) div 2;

      //Draw
      if cfpTopInnerBorder in VisibleParts then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpTopInnerBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := Filler.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Left+1, R.Top);
              aTargetBmp.Canvas.LineTo(R.Right, R.Top);
            end
          else
            begin
              Width := R.Right - R.Left - InnerBorder.Width * 2;
              PointFrom := Point(x, R.Top);
              PointTo := Point(x, R.Top + InnerBorder.Width - 1);
              ModifyFiller(cfpTopInnerBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if cfpRightInnerBorder in VisibleParts then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpRightInnerBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := Filler.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Right, R.Top + 1);
              aTargetBmp.Canvas.LineTo(R.Right, R.Bottom);
            end
          else
            begin
              Width := R.Bottom - R.Top - InnerBorder.Width * 2;
              PointFrom := Point(R.Right, y);
              PointTo := Point(R.Right - InnerBorder.Width + 1, y);
              ModifyFiller(cfpRightInnerBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if cfpBottomInnerBorder in VisibleParts then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpBottomInnerBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := Filler.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Right - 1, R.Bottom);
              aTargetBmp.Canvas.LineTo(R.Left, R.Bottom);
            end
          else
            begin
              Width := R.Right-R.Left - InnerBorder.Width * 2;
              d := Width mod 2;
              PointFrom := Point(x + d, R.Bottom);
              PointTo := Point(x + d, R.Bottom - InnerBorder.Width + 1);
              ModifyFiller(cfpBottomInnerBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if cfpLeftInnerBorder in VisibleParts then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpLeftInnerBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := Filler.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Left, R.Bottom - 1);
              aTargetBmp.Canvas.LineTo(R.Left, R.Top);
            end
          else
            begin
              Width := R.Bottom - R.Top - InnerBorder.Width * 2;
              d := Width mod 2;
              PointFrom := Point(R.Left, y + d);
              PointTo := Point(R.Left + InnerBorder.Width - 1, y + d);
              ModifyFiller(cfpLeftInnerBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientComplexFrame.DrawInnerCorners(aTargetBmp :TBitmap; aFiller: TLMDFiller);
var
  lrf: TLMDCustomCutRectangle;
  r: TRect;
  bw: integer;
begin
  if (InnerBorder.Width <= 0) or (cGradientCFrameInnerCorners*VisibleParts=[]) then
    exit;
  lrf := TLMDCustomCutRectangle.Create;

  R := InnerBorderRect;
  InflateRect(R, -InnerBorderGap, -InnerBorderGap);
  bw := InnerBorder.Width - 1;

  with lrf do
    begin
      CutX := bw;
      CutY := bw;
      //Initialize
      BorderSides := [];
      Transparent := false;
      AntiAliasing := true;
      SoftBorder := false;
      BorderColor := clNone;
      BorderWidth := 0;
      Filler := aFiller;

      if (cfpTopLeftInnerCorner in VisibleParts) then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpTopLeftOuterCorner, aFiller);
              aTargetBmp.Canvas.Pixels[R.Left, R.Top] := Filler.FixedColors[0];
            end
          else
            begin
              Rectangle(r.left, r.top, r.Left + bw, r.Top + bw);
              CornerCut[rcTopLeft] := ctRound;
              CornerCut[rcTopRight] := ctNone;
              CornerCut[rcBottomRight] := ctNone;
              CornerCut[rcBottomLeft] := ctNone;
              TLMDRoundFiller(Filler).Radius := bw;
              Filler.BasePoint := Point(r.left + bw, r.top + bw);
              ModifyFiller(cfpTopLeftInnerCorner, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpTopRightInnerCorner in VisibleParts) then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpTopRightInnerCorner, aFiller);
              aTargetBmp.Canvas.Pixels[R.Right, R.Top] := Filler.FixedColors[0];
            end
          else
            begin
              CornerCut[rcTopLeft] := ctNone;
              CornerCut[rcTopRight] := ctRound;
              CornerCut[rcBottomRight] := ctNone;
              CornerCut[rcBottomLeft] := ctNone;

              Rectangle(r.right - bw, r.top, r.right, r.Top + bw);
              TLMDRoundFiller(Filler).Radius := bw;
              Filler.BasePoint := Point(r.right - bw, r.top + bw);
              ModifyFiller(cfpTopRightInnerCorner, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpBottomRightInnerCorner in VisibleParts) then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpBottomRightInnerCorner, aFiller);
              aTargetBmp.Canvas.Pixels[R.Right, R.Bottom] := Filler.FixedColors[0];
            end
          else
            begin
              CornerCut[rcTopLeft] := ctNone;
              CornerCut[rcTopRight] := ctNone;
              CornerCut[rcBottomRight] := ctRound;
              CornerCut[rcBottomLeft] := ctNone;

              Rectangle(r.right - bw, r.bottom-bw, r.right, r.bottom);
              TLMDRoundFiller(Filler).Radius := bw;
              Filler.BasePoint := Point(r.right - bw, r.bottom - bw);
              ModifyFiller(cfpBottomRightInnerCorner, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpBottomLeftInnerCorner in VisibleParts) then
        begin
          if InnerBorder.Width = 1 then
            begin
              ModifyFiller(cfpBottomLeftInnerCorner, aFiller);
              aTargetBmp.Canvas.Pixels[R.Left, R.Bottom] := Filler.FixedColors[0];
            end
          else
            begin
              CornerCut[rcTopLeft] := ctNone;
              CornerCut[rcTopRight] := ctNone;
              CornerCut[rcBottomRight] := ctNone;
              CornerCut[rcBottomLeft] := ctRound;

              Rectangle(r.left, r.bottom-bw, r.left+bw, r.bottom);
              TLMDRoundFiller(Filler).Radius := bw;
              Filler.BasePoint := Point(r.left + bw, r.bottom - bw);
              ModifyFiller(cfpBottomLeftInnerCorner, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;
    end;
  lrf.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientComplexFrame.DrawInnerSpace(aTargetBmp :TBitmap; aFiller: TLMDFiller);
var
  lsf: TLMDSubtractionFigure;
  lSFiller : TLMDSolidFiller;
  r, r1, r2: TRect;
  bw: integer;
begin
  if (VisibleParts * cGradientCFrameSpace = []) then
    exit;
  lsf := TLMDSubtractionFigure.Create;
  lSFiller :=TLMDSolidFiller.Create;
  lSFiller.FixedAlpha[0] := FInnerSpaceOuterCornersAlpha;

  r:= OuterBorderRect;
  InflateRect(r, -1, -1);
  r1 := r;
  InflateRect(r,  -OuterBorderGap,  -OuterBorderGap);
  bw := InnerBorder.Width;
  r2 := InnerBorderRect;
  InflateRect(r2,  -InnerBorderGap,  -InnerBorderGap);

  lsf.Add(TLMDCustomCutRectangle.Create(r1));
  lsf.Add(TLMDCustomCutRectangle.Create(r));

  if cfpSpace in VisibleParts then
    begin
      with TLMDCustomCutRectangle(lsf.Item[0]) do
        begin
          CutX := bw;
          CutY := bw;
          if cfpSpaceTopLeftInnerCorner in VisibleParts then
            CornerCut[rcTopLeft] := FCutType[cfpSpaceTopLeftInnerCorner];
          if cfpSpaceTopRightInnerCorner in VisibleParts then
            CornerCut[rcTopRight] := FCutType[cfpSpaceTopRightInnerCorner];
          if cfpSpaceBottomRightInnerCorner in VisibleParts then
            CornerCut[rcBottomRight] := FCutType[cfpSpaceBottomRightInnerCorner];
          if cfpSpaceBottomLeftInnerCorner in VisibleParts then
            CornerCut[rcBottomLeft] := FCutType[cfpSpaceBottomLeftInnerCorner];
        end;

      with TLMDCustomCutRectangle(lsf.Item[1]) do
        begin
          CutX := bw;
          CutY := bw;
          if cfpSpaceTopLeftInnerCorner in VisibleParts then
            CornerCut[rcTopLeft] := FCutType[cfpSpaceTopLeftInnerCorner];
          if cfpSpaceTopRightInnerCorner in VisibleParts then
            CornerCut[rcTopRight] := FCutType[cfpSpaceTopRightInnerCorner];
          if cfpSpaceBottomRightInnerCorner in VisibleParts then
            CornerCut[rcBottomRight] := FCutType[cfpSpaceBottomRightInnerCorner];
          if cfpSpaceBottomLeftInnerCorner in VisibleParts then
            CornerCut[rcBottomLeft] := FCutType[cfpSpaceBottomLeftInnerCorner];
        end;

      with lsf do
        begin
          //Initialize
          BorderSides := [];
          Transparent := false;
          AntiAliasing := true;
          SoftBorder := false;
          BorderWidth := 0;

          Filler := lSFiller;
          lSFiller.Color := OuterBorderGapColor;
          Draw(aTargetBmp, FUsePixelFormat);

          lSFiller.Color := InnerBorderGapColor;
          TLMDCustomCutRectangle(Item[0]).Rectangle(InnerBorderRect);
          TLMDCustomCutRectangle(Item[1]).Rectangle(r2);
          Draw(aTargetBmp, FUsePixelFormat);

          TLMDCustomCutRectangle(Item[0]).Rectangle(r);
          TLMDCustomCutRectangle(Item[1]).Rectangle(InnerBorderRect);

          Filler := aFiller;

          ModifyFiller(cfpSpace, aFiller);
          Draw(aTargetBmp, FUsePixelFormat);
        end;
      lsf.Clear(true);  
      lsf.Free;
    end;

  if ((VisibleParts * cGradientCFrameSpaceOuterCorners) <> []) and (OuterBorder.Width <> 0) then
    begin
      lSFiller.Color := FInnerSpaceOuterCornersColor;
      lSFiller.FixedAlpha[0] := FInnerSpaceOuterCornersAlpha;

      lsf := TLMDSubtractionFigure.Create;
      r:= OuterBorderRect;
      bw := InnerBorder.Width;
      InflateRect(r, -1, -1);

      lsf.Add(TLMDRectangle.Create(r));
      //InflateRect(r, -1, -1);
      lsf.Add(TLMDCustomCutRectangle.Create(r));
      with TLMDCustomCutRectangle(lsf.Item[1]) do
        begin
          CutX := bw;
          CutY := bw;
          if cfpSpaceTopLeftOuterCorner in VisibleParts then
            CornerCut[rcTopLeft] := FCutType[cfpSpaceTopLeftOuterCorner];
          if cfpSpaceTopRightOuterCorner in VisibleParts then
            CornerCut[rcTopRight] := FCutType[cfpSpaceTopRightOuterCorner];
          if cfpSpaceBottomRightOuterCorner in VisibleParts then
            CornerCut[rcBottomRight] := FCutType[cfpSpaceBottomRightOuterCorner];
          if cfpSpaceBottomLeftOuterCorner in VisibleParts then
            CornerCut[rcBottomLeft] := FCutType[cfpSpaceBottomLeftOuterCorner];
        end;
      with lsf do
        begin
          //Initialize
          BorderSides := [];
          Transparent := false;
          AntiAliasing := true;
          SoftBorder := false;
          BorderColor := clNone;
          BorderWidth := 0;
          Filler := lSFiller;
          Draw(aTargetBmp, FUsePixelFormat);
        end;
      lsf.Clear(true);  
      lsf.Free;
    end;
  lSFiller.Free;    
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientComplexFrame.DrawOuterBorder(aTargetBmp :TBitmap; aFiller: TLMDFiller);
var
  lf: TLMDLine;
  R, BR: TRect;
  d, x, y: integer;
begin
  FInnerSpaceOuterCornersColor := TLMDLineFiller(aFiller).FixedColors[0];
  FInnerSpaceOuterCornersAlpha := TLMDLineFiller(aFiller).FixedAlpha[0];

  if (OuterBorder.Width <= 0) or (cGradientCFrameOuterBorders*VisibleParts=[]) then
    exit;

  R := OuterBorderRect;
  BR := BoundsRect;

  lf := TLMDLine.Create(0,0,0,0,0);

  with lf do
    begin
      //Initialize
      BorderSides := [];
      Transparent := false;
      AntiAliasing := true;
      SoftBorder := false;
      BorderColor := clNone;
      BorderWidth := 0;
      Filler := aFiller;

      x := (R.Left+R.Right) div 2;
      y := (R.Top + R.Bottom) div 2;

      //Draw
      if (cfpTopOuterBorder in VisibleParts) then
        begin
          if OuterBorder.Width = 1 then
            begin
              ModifyFiller(cfpTopOuterBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := aFiller.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Left+1, R.Top);
              aTargetBmp.Canvas.LineTo(R.Right, R.Top);
            end
          else
            begin
              PointFrom := Point(x, R.Top);
              PointTo := Point(x, BR.Top);
              Width := R.Right-R.Left;
              ModifyFiller(cfpTopOuterBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpRightOuterBorder in VisibleParts) then
        begin
          if OuterBorder.Width = 1 then
            begin
              ModifyFiller(cfpRightOuterBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := aFiller.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Right, R.Top + 1);
              aTargetBmp.Canvas.LineTo(R.Right, R.Bottom);
            end
          else
            begin
              Width := R.Bottom - R.Top;
              PointFrom := Point(R.Right, y);
              PointTo := Point(BR.Right, y);
              ModifyFiller(cfpRightOuterBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpBottomOuterBorder in VisibleParts) then
        begin
          if OuterBorder.Width = 1 then
            begin
              ModifyFiller(cfpBottomOuterBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := aFiller.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Right - 1, R.Bottom);
              aTargetBmp.Canvas.LineTo(R.Left, R.Bottom);
            end
          else
            begin
              Width := R.Right-R.Left;
              d := Width mod 2;
              PointFrom := Point(x + d, R.Bottom);
              PointTo := Point(x + d, BR.Bottom);
              ModifyFiller(cfpBottomOuterBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;

      if (cfpLeftOuterBorder in VisibleParts) then
        begin
          if OuterBorder.Width = 1 then
            begin
              ModifyFiller(cfpLeftOuterBorder, aFiller);
              aTargetBmp.Canvas.Pen.Color := aFiller.FixedColors[0];
              aTargetBmp.Canvas.MoveTo(R.Left, R.Bottom - 1);
              aTargetBmp.Canvas.LineTo(R.Left, R.Top);
            end
          else
            begin
              Width := R.Bottom - R.Top;
              d := Width mod 2;
              PointFrom := Point(R.Left, y + d);
              PointTo := Point(BR.Left, y + d);
              ModifyFiller(cfpLeftOuterBorder, aFiller);
              Draw(aTargetBmp, FUsePixelFormat);
            end;
        end;
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGradientComplexFrame.DrawOuterCorners(aTargetBmp :TBitmap; aFiller: TLMDFiller);
var
  lcr: TLMDCustomCutRectangle;
  R: TRect;
begin
  if (OuterBorder.Width <= 0) or (GradientCFrameOuterCorners*VisibleParts=[]) then
    exit;

  R := OuterBorderRect;

  lcr := TLMDCustomCutRectangle.Create(0,0,0,0);

  with lcr do
  begin
    CutX := OuterBorder.Width;
    CutY := OuterBorder.Width;
    Transparent := false;
    AntiAliasing := true;
    SoftBorder := false;
    BorderWidth := 0;
    Filler := aFiller;

    if cfpTopLeftOuterCorner in VisibleParts then
      begin
        if OuterBorder.Width = 1 then
          begin
            ModifyFiller(cfpTopLeftOuterCorner, aFiller);
            aTargetBmp.Canvas.Pixels[R.Left, R.Top] := Filler.FixedColors[0];
          end
        else
          begin
            CornerCut[rcTopLeft] := FCutType[cfpTopLeftOuterCorner];
            CornerCut[rcBottomLeft] := ctNone;
            CornerCut[rcTopRight] := ctNone;
            CornerCut[rcBottomRight] := ctNone;
            Rectangle(BoundsRect.Left, BoundsRect.Top, R.Left, R.Top);
            TLMDRoundFiller(Filler).Radius := OuterBorder.Width - 1;
            Filler.BasePoint := Point(R.Left, R.Top);
            ModifyFiller(cfpTopLeftOuterCorner, aFiller);
            Draw(aTargetBmp, FUsePixelFormat);
          end;
      end;

    if cfpTopRightOuterCorner in VisibleParts then
      begin
        if OuterBorder.Width = 1 then
          begin
            ModifyFiller(cfpTopRightOuterCorner, aFiller);
            aTargetBmp.Canvas.Pixels[R.Right, R.Top] := Filler.FixedColors[0];
          end
        else
          begin
            CornerCut[rcTopRight] := FCutType[cfpTopRightOuterCorner];
            CornerCut[rcTopLeft] := ctNone;
            CornerCut[rcBottomLeft] := ctNone;
            CornerCut[rcBottomRight] := ctNone;
            Rectangle(R.Right, BoundsRect.Top, BoundsRect.Right, R.Top);
            TLMDRoundFiller(Filler).Radius := OuterBorder.Width - 1;
            Filler.BasePoint := Point(R.Right, R.Top);
            ModifyFiller(cfpTopRightOuterCorner, aFiller);
            Draw(aTargetBmp, FUsePixelFormat);
          end;
      end;

    if cfpBottomRightOuterCorner in VisibleParts then
      begin
        if OuterBorder.Width = 1 then
          begin
            ModifyFiller(cfpBottomRightOuterCorner, aFiller);
            aTargetBmp.Canvas.Pixels[R.Right, R.Bottom] := Filler.FixedColors[0];
          end
        else
          begin
            CornerCut[rcBottomRight] := FCutType[cfpBottomRightOuterCorner];
            CornerCut[rcTopLeft] := ctNone;
            CornerCut[rcBottomLeft] := ctNone;
            CornerCut[rcTopRight] := ctNone;
            Rectangle(R.Right, R.Bottom, BoundsRect.Right, BoundsRect.Bottom);
            TLMDRoundFiller(Filler).Radius := OuterBorder.Width - 1;
            Filler.BasePoint := Point(R.Right, R.Bottom);
            ModifyFiller(cfpBottomRightOuterCorner, aFiller);
            Draw(aTargetBmp, FUsePixelFormat);
          end;
      end;

    if cfpBottomLeftOuterCorner in VisibleParts then
      begin
        if OuterBorder.Width = 1 then
          begin
            ModifyFiller(cfpBottomLeftOuterCorner, aFiller);
            aTargetBmp.Canvas.Pixels[R.Left, R.Bottom] := Filler.FixedColors[0];
          end
        else
          begin
            CornerCut[rcBottomLeft] := FCutType[cfpBottomLeftOuterCorner];
            CornerCut[rcTopLeft] := ctNone;
            CornerCut[rcTopRight] := ctNone;
            CornerCut[rcBottomRight] := ctNone;
            Rectangle(BoundsRect.Left, R.Bottom, R.Left, BoundsRect.Bottom);
            TLMDRoundFiller(Filler).Radius := OuterBorder.Width - 1;
            Filler.BasePoint := Point(R.Left, R.Bottom);
            ModifyFiller(cfpBottomLeftOuterCorner, TLMDFiller(aFiller));
            Draw(aTargetBmp, FUsePixelFormat);
          end;
      end;
    Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientComplexFrame.ModifyFiller(aFramePart: TLMDGradientComplexFramePartKind;
  var aFiller: TLMDFiller): boolean;
begin
  if Assigned(ModifyFillerFunc) then
    result := ModifyFillerFunc(aFramePart, aFiller)
  else
    result := false;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDGradientComplexFrame.Create;
var
  p: TLMDGradientComplexFramePartKind;
begin
  inherited;
  for p := low(TLMDGradientComplexFramePartKind) to high(TLMDGradientComplexFramePartKind) do
    FCutType[p] := ctRound;
  VisibleParts := cGradientCFrameAllParts;
end;


{ ---------------------------------------------------------------------------- }
destructor TLMDBaseGradientFrame.Destroy;
begin
  inherited;
end;

{---------------- TLMDGradientSimpleFramePart ---------------------------------}
constructor TLMDGradientFramePartBase.Create;
begin
  FWidth := 0;
  FEdgeWidth := 0;
  FEdgeColor := clNone;
  FAntiAliasing := true;
  FSoftEdge := false;
  FFiller := nil;
end;

{----------------  TLMDGradientRectFramePart ----------------------------}
constructor TLMDGradientRectFramePart.Create;
begin
  inherited;
  FInnerCutX := 0;
  FInnerCutY := 0;
  FOuterCutX := 0;
  FOuterCutY := 0;
  FInnerCutXValueType := vtAbsolute;
  FInnerCutYValueType := vtAbsolute;
  FOuterCutXValueType := vtAbsolute;
  FOuterCutYValueType := vtAbsolute;
  OuterCutType := cRectCorners;
  InnerCutType := cRectCorners;
end;

{---------------- TLMDGradientCircleFramePart ---------------------------}
constructor TLMDGradientCircleFramePart.Create;
begin
  inherited;
  FRadius := 0;
  FCenter := Point(0,0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientComplexFrame.GetInnerBorder: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FInnerBorder);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientComplexFrame.GetInnerSpace: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FInnerSpace);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGradientComplexFrame.GetOuterBorder: TLMDGradientRectFramePart;
begin
  result := TLMDGradientRectFramePart(FOuterBorder);
end;

end.

