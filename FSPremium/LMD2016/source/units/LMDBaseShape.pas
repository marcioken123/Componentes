unit LMDBaseShape;
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

LMDBaseShape unit (RM)
----------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics,
  LMDShadow, LMDShapeBase, LMDBase, LMDGraph, LMDCaption, LMDShapeFill, LMDSimpleBevel,
  LMDPointList, LMDTeeth, LMDShape, LMDBaseGraphicControl, LMDClass, LMDTypes;

type
  TLMDShapeControlMode=(scmShapeFast, scmShapeFill, scmTeethFast, scmTeethFill);

  {------------------------ TLMDBaseShape -------------------------------------}
  TLMDBaseShape = class(TLMDBaseGraphicControl)
    private
      FBevel         : TLMDSimpleBevel;
      FBrush         : TBrush;
      FBrushBackColor: TColor;
      FCaption       : TLMDCaption;
      FCaptionClip   : Boolean;
      FList          : TLMDPointList;
      FRoundPercent  : TLMDPercent;
      FShadow        : TLMDShadow;
      FShape         : TLMDShapeType;
      FSquare        : Boolean;
      FTeeth,
      FTPointer      : TLMDTeeth;
      FMode          : TLMDShapeControlMode;

      procedure SetShapeFill(aValue:TLMDShapeFill);
      procedure SetMode(aValue:TLMDShapeControlMode);
      //--
      procedure SetBevel(aValue: TLMDSimpleBevel);
      procedure SetBrush(aValue: TBrush);
      procedure SetBrushBackColor(aValue: TColor);
      procedure SetCaption(aValue: TLMDCaption);
      procedure SetCaptionClip(aValue: Boolean);
      procedure SetRoundPercent(aValue: TLMDPercent);
      procedure SetShadow(aValue: TLMDShadow);
      procedure SetShape(aValue: TLMDShapeType);
      procedure SetSquare(aValue: Boolean);
      procedure SetTeeth(aValue: TLMDTeeth);
    protected
      FChange        : Boolean;
      FShapeFill     : TLMDShapeFill;
      FCacheBitmap   : TBitmap;

      procedure GetShapeChange;
      procedure OffscreenPaint;
            procedure BoundsChange(State:TLMDBoundsChangeStates);override;
      Procedure DrawCaption(aCanvas: TCanvas; aRect: TRect); virtual;
      procedure GetChange(Sender:TObject);override;
      function GetGradientRect:TRect;virtual;
      procedure GetIMLChange(Sender:TObject); override;
      function GetLabelText:String; virtual;
      function GetPalette:HPalette;override;
      procedure PaintToCanvas (aCanvas : TCanvas);      
      procedure Paint;override;
    public
      constructor Create(aOwner: TComponent);override;
      destructor Destroy;override;
      procedure SaveToFile (const Filename : String);
      property Mode:TLMDShapeControlMode read FMode write SetMode default scmShapeFast;
      property Teeth: TLMDTeeth read FTeeth write SetTeeth;
    published
      property About;
      property Align;
      property Bevel: TLMDSimpleBevel read FBevel write SetBevel;
      property Brush: TBrush read FBrush write SetBrush;
      property BrushBackColor:TColor read FBrushBackColor write SetBrushBackColor default clBtnFace;
      property Caption:TLMDCaption read FCaption write SetCaption;
      property CaptionClip:Boolean read FCaptionClip write SetCaptionClip default false;
      property Color;
      property DragCursor;
      property DragMode;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property RoundPercent: TLMDPercent read FRoundPercent write SetRoundPercent default 33;
      property Shadow: TLMDShadow read FShadow write SetShadow;
      property Shape: TLMDShapeType read FShape write SetShape default stRectangle;
      property ShowHint;
      property Square: Boolean read FSquare write SetSquare default False;
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
      property BiDiMode;
      property Constraints;
      property ParentBiDiMode;
      //events
      property OnEndDock;
      property OnStartDock;
      property OnContextPopup;
      {$IFDEF LMDCOMP9}
      property OnMouseActivate;
      {$ENDIF}
      //4.0
      property ShapeFill: TLMDShapeFill read FShapeFill write SetShapeFill;
  end;

implementation

uses
  Types, Controls,
  LMDCont, LMDProcs, LMDGraphUtils, LMDCustomImageList;

{************************ Object TLMDBaseShape ********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDBaseShape.SetBevel(aValue: TLMDSimpleBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetBrush(aValue: TBrush);
begin
  FBrush.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetBrushBackColor(aValue: TColor);
begin
  if FBrushBackColor<>aValue then
    begin
      FBrushBackColor:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetCaption(aValue:TLMDCaption);
begin
  FCaption.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetCaptionClip(aValue:Boolean);
begin
  if aValue<>FCaptionClip then
    begin
      FCaptionClip:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetMode(aValue:TLMDShapeControlMode);
begin
  if aValue<>FMode then
    begin
      FMode:=aValue;
      if FMode in [scmTeethFast, scmTeethFill] then FTPointer:=FTeeth else FTPointer:=nil;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetRoundPercent(aValue: TLMDPercent);
begin
  if FRoundPercent<>aValue then
    begin
      FRoundPercent:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetShapeFill(aValue:TLMDShapeFill);
begin
  FShapeFill.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetShadow(aValue: TLMDShadow);
begin
  FShadow.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetShape(aValue: TLMDShapeType);
begin
  if aValue<>FShape then
    begin
      FShape:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetSquare(aValue: Boolean);
begin
  if aValue<>FSquare then
    begin
      FSquare:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SetTeeth(aValue: TLMDTeeth);
begin
  FTeeth.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDBaseShape.GetGradientRect:TRect;
begin
  result:=ClientRect;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDBaseShape.GetShapeChange;
begin
  if Assigned(FCacheBitmap) then
    begin
      FCacheBitmap.Free;
      FCacheBitmap:=nil;
    end;
  if FMode in [scmShapeFill, scmTeethFill] then FCacheBitmap:=TBitmap.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.OffscreenPaint;
var
  aRect: TRect;
begin
  aRect:=GetGradientRect;
  OffsetRect(aRect,-aRect.Left,-aRect.Top);
  FCacheBitmap.Width:=aRect.Right;
  FCacheBitmap.Height:=aRect.Bottom;

  with FShapeFill do
    case Style of
      sfBrush:
        LMDShapeDraw(ClientRect,FCacheBitmap.Canvas,FShape,FTPointer,FList,FSquare,FBrush,
                     FRoundPercent,FBevel,FShadow,nil,Color,BrushBackColor,0);
      sfGradient:
        FShapeFill.Gradient.PaintGradient(FCacheBitmap.Canvas, aRect);
      sfBitmap, sfBitmapList:
        with FCacheBitmap do
          begin
            Canvas.Brush.Style:=bsSolid;
            Canvas.Brush.Color:=Color;
            Canvas.FillRect(aRect);
            if not ((FShapeFill.CurrentBitmap=nil) or (FShapeFill.CurrentBitmap.Empty)) then
                   LMDBmpDraw(Canvas,aRect, CurrentBitmap, LMDTileMode2DSF(FShapeFill.TileMode),clBlack);
          end;
  end;
  if FTPointer<>nil then
    case FTPointer.Direction of
      tdRight:
        aRect.Right:=aRect.Right-FTPointer.Width;
      tdLeft:
        aRect.Left:=aRect.Left+FTPointer.Width;
      tdDown:
        aRect.Bottom:=aRect.Bottom-FTPointer.Height;
      tdUp:
        aRect.Top:=aRect.Top+FTPointer.Height;
    end;
  if FCaptionClip then DrawCaption(FCacheBitmap.Canvas, aRect)
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.BoundsChange(State:TLMDBoundsChangeStates);
begin
  inherited BoundsChange(State);
  if State=[bcPos] then exit;
  {RM}
  FChange:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.DrawCaption(aCanvas: TCanvas; aRect: TRect);
var
  FShadowDepth: integer;
begin
  InflateRect(aRect,-FBevel.Width,-FBevel.Width);
  if FShadow.Style=hssNone then
    FShadowDepth:=0
  else
    FShadowDepth:=FShadow.Depth;
  aRect.Right:=aRect.Right-FShadowDepth;
  aRect.Bottom:=aRect.Bottom-FShadowDepth;
  OffsetRect(aRect,-aRect.Left+FBevel.Width,-aRect.Top+FBevel.Width);

  FCaption.DrawCaption(aCanvas, GetLabelText, aRect,[TLMDDrawTextStyle(Enabled)],
                       Color,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.GetChange(Sender: TObject);
begin
  {if (csLoading in ComponentState) then exit;}
  if FMode in [scmTeethFast, scmTeethFill] then FTPointer:=FTeeth else FTPointer:=nil;
  if not (Sender is TLMDCaption) then
    LMDShapeCalc(ClientRect,FShape,FTPointer,FSquare,FBrush,FRoundPercent,FBevel,FShadow,
     FList);
  GetShapeChange;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDBaseShape.GetLabelText:String;
begin
  result:=FCaption.Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FShapeFill.ListBitmap)
  else
    FShapeFill.ListBitmap:=nil;
  inherited GetIMLChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDBaseShape.GetPalette:HPalette;
begin
  result:=0;
  if FMode in [scmShapeFill, scmTeethFill] then result:=FShapeFill.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.PaintToCanvas (aCanvas : TCanvas);
var
  aRect: TRect;
  flags:word;
  Temp:TBitmap;
  tempBrush: TBrush;
begin
  {RM}
  if FChange then
    begin
      LMDShapeCalc(Rect(0,0, Width, Height),FShape,FTPointer,FSquare,FBrush,
          FRoundPercent,FBevel,FShadow, FList);
      GetShapeChange;
      FChange:=False;
      {exit;}
    end;

  if FMode in [scmShapeFast, scmTeethFast] then
    begin
      if not Transparent then FillControl;
      if Assigned(FCacheBitmap) then
        begin
          FCacheBitmap.Free;
          FCacheBitmap:=nil;
        end;
      if FMode=scmShapeFast then
         LMDShapeDraw(ClientRect,aCanvas,FShape,FTPointer, FList,FSquare,FBrush,
                      FRoundPercent,FBevel,FShadow,nil,Color,FBrushBackColor,0)
      else
         LMDShapeDraw(ClientRect,aCanvas,FShape,FTPointer,FList,FSquare,FBrush,
                      FRoundPercent,FBevel,FShadow,nil,Color,FBrushBackColor,0);
      {now draw the Caption}
      DrawCaption(aCanvas, ClientRect);
    end
  else
    begin
      if not Assigned(FCacheBitmap) then FCacheBitmap:=TBitmap.Create;
      if FCacheBitmap.Empty then OffscreenPaint;
      aRect:=ClientRect;
      Temp:=nil;
      tempBrush:=nil;

      case FShapeFill.Style of
        sfBrush,sfGradient,sfBitmap, sfBitmapList:
          begin
            try
              Temp:=TBitmap.Create;
              LMDBmpCreateFromRect(Temp,ClientRect,Color);
              flags:=0;
              if not Transparent then FillControl;
              if FShapeFill.Style=sfGradient then
                FShapeFill.Gradient.SetRealPalette(Canvas);
              LMDShapeDraw(ClientRect,Temp.Canvas,FShape, FTPointer, FList,FSquare,FBrush,
                           FRoundPercent,FBevel,FShadow,FCacheBitmap, ColorToRgb(Color),BrushBackColor, flags);
              LMDBmpDraw(aCanvas,ClientRect,Temp, DSF_TRANSPARENCY, ColorToRgb(Color));
            finally
              Temp.Free;
            end;
          end;
        sfNone,sfBrushBitmap:
          begin
            if not Transparent then FillControl;
            try
              tempBrush:=TBrush.Create;
              case FShapeFill.Style of
                sfNone: tempBrush.Style:=bsClear;
                sfBrushBitmap: tempBrush.Bitmap:=FShapeFill.Bitmap;
              end;
              LMDShapeDraw(ClientRect,aCanvas,FShape,FTPointer,FList,FSquare,tempBrush,
                           FRoundPercent,FBevel,FShadow,nil,Color,BrushBackColor,0);
            finally
              tempBrush.Free;
            end;
          end;
      end;{case}

      if FTPointer<>nil then
        case FTPointer.Direction of
          tdRight:
            aRect.Right:=aRect.Right-FTPointer.Width;
          tdLeft:
            aRect.Left:=aRect.Left+FTPointer.Width;
          tdDown:
            aRect.Bottom:=aRect.Bottom-FTPointer.Height;
          tdUp:
            aRect.Top:=aRect.Top+FTPointer.Height;
        end;

      {now draw the caption}
      if not FCaptionClip then DrawCaption(aCanvas, aRect);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.Paint;

begin
  if [csLoading, csReading]*ComponentState<>[] then exit;
  PaintToCanvas (Canvas);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBaseShape.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  {RM}
  FChange:=True;

  FBevel:=TLMDSimpleBevel.Create;
  FBrush:=TBrush.Create;
  FCaption:=TLMDCaption.Create;

  FCaption.Alignment:=agCenter;
  FCaption.Default:=False;
  FCaptionClip:=False;

  FList:=TLMDPointList.Create;
  FShadow:=TLMDShadow.Create;

  FBevel.OnChange:=GetChange;
  FBrush.OnChange:=GetChange;
  FCaption.OnChange:=GetChange;
  FShadow.OnChange:=GetChange;

  FRoundPercent:=33;
  FShape:=stRectangle;
  FSquare:=False;
  FBrushBackColor:=clBtnFace;

  // 4.0
  FMode:=scmShapeFast;
  FCacheBitmap:=nil;
  FShapeFill:=TLMDShapeFill.Create;
  FShapeFill.OnChange:=GetChange;
  FTeeth:=TLMDTeeth.Create;
  FTeeth.OnChange:=GetChange;
  FTPointer:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseShape.Destroy;
begin
  FShapeFill.OnChange:=nil;
  FBevel.OnChange:=nil;
  FBrush.OnChange:=nil;
  FCaption.OnChange:=nil;
  FShadow.OnChange:=nil;
  FTeeth.OnChange:=nil;
  FBevel.Free;
  FBrush.Free;
  FCaption.Free;
  FList.Free;
  FShadow.Free;
  FShapeFill.Free;
  FTeeth.Free;

  //4.0
  if Assigned(FCacheBitmap) then FCacheBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseShape.SaveToFile (const Filename : String);
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.Width := Width;
    bmp.Height := Height;
    PaintToCanvas (bmp.Canvas);
    bmp.SaveToFile (Filename);
  finally
    bmp.Free;
  end;
end;

end.
