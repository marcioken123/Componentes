unit LMDCustomShapeButton;
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

LMDCustomShapeButton unit (RM)
------------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, ImgList,
  LMDShapeBase, LMDBase, LMDClass, LMDGraph, LMDShapeButtonColor, LMDShape,
  LMDPointList, LMDCont, LMDShadow, LMDShapeFill, LMDBaseGraphicButton,
  LMDCustomImageList, LMDBaseController;

type
  TLMDShapeButtonStyle=(sbsShadow, sbs3D);

  {----------------------TLMDCustomShapeButton---------------------------------}
  TLMDCustomShapeButton = class(TLMDBaseGraphicButton)
  private
    FShape            : TLMDShape;
    FColors           : TLMDShapeButtonColor;
    FBitmap           : TBitmap;
    FShapeFill        : TLMDShapeFill;
    FBtnFaceImageList : TCustomImageList;
    FBtnFaceIndex,
    FBtnFaceListIndex : Integer;
    FBtnFaceChangeLink: TChangeLink;
    procedure SetBtnFaceImageList(aValue:TCustomImageList);
    procedure SetBtnFaceIndex(index, aValue:Integer);
    procedure SetMode(aValue:TLMDShapeButtonMode);
    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    {----  }
    procedure SetShapeFill(aValue: TLMDShapeFill);
    procedure SetColors(aValue: TLMDShapeButtonColor);
    procedure SetBevel3D(aValue: Boolean);
    procedure SetShape(aValue: TLMDShape);
    procedure SetShapeStyle(aValue: TLMDShapeButtonStyle);
    procedure ReadBool(Reader:TReader);
  protected
    FStyle            : TLMDShapeButtonStyle;
    FMode             : TLMDShapeButtonMode;
    FBevel3D          : Boolean;
    FBrush            : TBrush;
    FList             : TLMDPointList;

    procedure BoundsChange(State:TLMDBoundsChangeStates); override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure GetIMLFaceChange(Sender:TObject);
    procedure GetChange(Sender: TObject);override;
    function GetPalette:HPalette;override;
    function IMLFaceEmpty:Boolean;
    function IsCustom:Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    function ButtonColorChange: Boolean; override;
    function VerifyTransparency(X, Y: Integer): Boolean; override;
    property Bevel3D: Boolean read FBevel3D write SetBevel3D default False;
  protected
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    property MouseOver;
  published
    // 7.0
    property ButtonLayout;
    property EnterColor;
    property EnterColorChange;
    property Glyph;
    property Font;
    property FontFX;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property NumGlyphs;
    property RepeatedClick;
    property RepeatingInterval;
    property RepeatingDelay;
    property UseCaption;
    property OnDropDown;
    // ---

    property AllowTransparency;
    property AllowMouseOver;
    property AllowAllUp;
    property Colors: TLMDShapeButtonColor read FColors write SetColors;
    property GroupIndex;
    property Pressed;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property Mode:TLMDShapeButtonMode read FMode write SetMode default sbmShapeFast;
    property Shape: TLMDShape read FShape write SetShape;
    property Style: TLMDShapeButtonStyle read FStyle write SetShapeStyle default sbsShadow;
    property Transparent;
    property ShapeFill: TLMDShapeFill read FShapeFill write SetShapeFill;
    property ShapeFillImageList:TCustomImageList read FBtnFaceImageList write SetBtnFaceImageList stored HasControl;
    property ShapeFillImageIndex:Integer index 0 read FBtnFaceIndex write SetBtnFaceIndex default 0;
    property ShapeFillListIndex:Integer index 1 read FBtnFaceListIndex write SetBtnFaceIndex default 0;
    property MultiLine;
  end;

implementation
uses
  Types, Controls,
  LMDButtonBase, LMDGraphUtils, LMDSimpleBevel, LMDCustomControl, LMDProcs;

{************************ Object TLMDCustomShapeButton ************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomShapeButton.SetBevel3D(aValue: Boolean);
begin
  if FBevel3D<>aValue then
    begin
      FBevel3D:=aValue;
      GetChange(nil)
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetShape(aValue: TLMDShape);
begin
  FShape.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetMode(aValue: TLMDShapeButtonMode);
begin
  if FMode<>aValue then
    begin
      FMode:=aValue;
      if FMode=sbmShapeFast then
        begin
          FBitmap.Free; FBitmap:=TBitmap.Create;
        end;
      GetChange(nil)
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetShapeStyle(aValue: TLMDShapeButtonStyle);
begin
  if FStyle<>aValue then
    begin
      FStyle:=aValue;
      GetChange(nil)
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetColors(aValue: TLMDShapeButtonColor);
begin
  FColors.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetBtnFaceImageList(aValue:TCustomImageList);
begin
  if FBtnFaceImageList<>nil then
    FBtnFaceImageList.UnRegisterChanges(FBtnFaceChangeLink);
  FBtnFaceImageList:=aValue;
  if FBtnFaceImageList<>nil then
    begin
      FBtnFaceImageList.RegisterChanges(FBtnFaceChangeLink);
      FBtnFaceImageList.FreeNotification(Self);
    end;
  GetIMLFaceChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetBtnFaceIndex(index, aValue:Integer);
begin
  case index of
    0: if (aValue=FBtnFaceIndex) or (aValue<0) then exit else FBtnFaceIndex:=aValue;
    1: if (aValue=FBtnFaceListIndex) or (aValue<0) then exit else FBtnFaceListIndex:=aValue;
  end;
  if FBtnFaceImageList<>nil then GetIMLFaceChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.ReadIdent(Reader:TReader);
begin
  SetBtnFaceImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.ReadBool(Reader:TReader);
begin
  Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FBtnFaceImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FBtnFaceImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.HasControl:Boolean;
begin
  result:=(FBtnFaceImageList<>nil) and (FBtnFaceImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.SetShapeFill(aValue: TLMDShapeFill);
begin
  FShapeFill.Assign(aValue);
end;

{------------------------- Protected-------------------------------------------}
procedure TLMDCustomShapeButton.BoundsChange(State:TLMDBoundsChangeStates);
begin
  inherited BoundsChange(State);
  if bcSize in State then GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL+'Btn', ReadIdent, WriteIdent, CheckCont);
  Filer.DefineProperty('CaptionClip', ReadBool, nil, false);
  Filer.DefineProperty('MouseOver', ReadBool, nil, false);
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.ButtonColorChange: Boolean;
begin
  if Colors.Up <> Colors.MouseOver then
    result := true
  else
    result := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.GetChange(Sender: TObject);
var
  aRect: TRect;
begin
  if (FShape=nil) or (FList=nil) or (FBrush=nil) or (FShapeFill=nil) then
    Exit;

  if FMode=sbmShapeFill then
  begin
    //if FBitmap=nil then exit;
    aRect := ClientRect;
    if IsRectEmpty(aRect) then
      Exit;

    FBitmap.Width  := aRect.Right;
    FBitmap.Height := aRect.Bottom;

    with FShapeFill do
      case Style of
        sfGradient:
          FShapeFill.Gradient.PaintGradient(FBitmap.Canvas, aRect);
        sfBitmap, sfBitmapList:
          with FBitmap do
          begin
            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := Color;
            Canvas.FillRect(aRect);
            if not ((FShapeFill.CurrentBitmap = nil) or FShapeFill.CurrentBitmap.Empty) then
              LMDBmpDraw(Canvas, aRect, FShapeFill.CurrentBitmap, LMDTileMode2DSF(FShapeFill.TileMode), 0);
          end;
      end;
  end;

  with FShape do
   if Style=sbs3D then
     LMDShapeCalc(ClientRect, Shape, nil, Square, FBrush, RoundPercent, Bevel, nil, FList)
   else
     LMDShapeCalc(ClientRect, Shape, nil, Square, FBrush, RoundPercent, Bevel, Shadow, FList);

  FShadowDepth := FShape.Shadow.Depth;

  if Transparent and (FMode = sbmShapeFill) then
  begin
    if Visible then
      Paint;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.VerifyTransparency(X, Y: Integer): Boolean;
var

  pp: PPoints;
  TP: TPoint;
  tmp: Integer;

  tempRgn: HRgn;
  RoundValue, i: Integer;
begin
  tmp:=0;
  tempRgn:=0;
  pp:=nil;

  with FShape do
    RoundValue:=integer((RoundPercent*LMDMin([Width-Shadow.Depth,Height-Shadow.Depth])) div 100);

  case FShape.Shape of
    stRectangle, stRoundRect, stEllipse:
  else
    begin
      tmp:=(FList.Count div 2)*SizeOf(TPoint);
      GetMem(pp,tmp);
      for i:=0 to (FList.Count div 2)-1 do
        begin
          TP:=FList.Points[i];
          pp^[i]:=TP;
          end;
    end;
  end;

  try
    with FList do
      case FShape.Shape of
        stRectangle:
          tempRgn:=CreateRectRgn(Points[0].x,Points[0].y,Points[1].x,Points[1].y);
        stRoundRect:
          tempRgn:=CreateRoundRectRgn(Points[0].x,Points[0].y,Points[1].x,Points[1].y,RoundValue,RoundValue);
        stEllipse:
          tempRgn:=CreateEllipticRgn(Points[0].x,Points[0].y,Points[1].x,Points[1].y);

        stDirectUp,stDirectRight,stDirectDown,stDirectLeft,
        stDiamond,stComb,stOctagon,stStar:
        tempRgn:=CreatePolygonRgn(pp^, (FList.Count div 2),WINDING);
        end;

    OffsetRgn(tempRgn, -FShape.Shadow.Depth, -FShape.Shadow.Depth);

    try
      if tempRgn<>0 then
        result:=PtInRegion(tempRgn,X,Y)
      else
        result:=True;
    finally
      DeleteObject(tempRgn);
    end;

  finally
    if tmp > 0 then
      FreeMem(pp, tmp);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.Loaded;
begin
  inherited Loaded;
  if FShape.Shape=stRectangle then
    begin
      with FShape do
        if Style=sbs3D then
          LMDShapeCalc(ClientRect,Shape,nil,Square,FBrush,RoundPercent,
           Bevel,nil,FList)
        else
          LMDShapeCalc(ClientRect,Shape,nil,Square,FBrush,RoundPercent,
           Bevel,Shadow,FList);

      FShadowDepth:=FShape.Shadow.Depth;
    end;
  {5.0 + 7.02 fix}
  if LMDIsCollectionImageList(FBtnFaceImageList) or
     LMDIsGlobalIdent(FBtnFaceImageList) then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.IMLFaceEmpty:Boolean;
begin
  result:=not ((FBtnFaceImageList<>nil) and LMDIMLIsValidItem(FBtnFaceImageList, FBtnFaceListIndex, FBtnFaceIndex));
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.IsCustom:Boolean;
begin
  result:=not HasIML;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.GetIMLFaceChange(Sender:TObject);
begin
  if not IMLFaceEmpty then
     LMDIMLItemBitmap(FBtnFaceImageList, FBtnFaceListIndex, FBtnFaceIndex, FShapeFill.ListBitmap)
  else
    FShapeFill.ListBitmap:=nil;
  GetChange(sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeButton.GetPalette:HPalette;
begin
  result:=FShapeFill.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FBtnFaceImageList) then SetBtnFaceImageList(nil);
end ;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomShapeButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBevel3D:=False;
  FBrush:=TBrush.Create;
  FList:=TLMDPointList.Create;
  ControlStyle:=[csCaptureMouse, csDoubleClicks, csReplicatable];
  FStyle:=sbsShadow;
  FShape:=TLMDShape.Create;
  AllowMouseOver:=True;
  FColors:=TLMDShapeButtonColor.Create;
  //Label
  FBtnFaceListIndex:=0;
  FBtnFaceIndex:=0;
  FBtnFaceImageList:=nil;
  FBtnFaceChangeLink:=TChangeLink.Create;
  FBitmap:=TBitmap.Create;
  FShapeFill:=TLMDShapeFill.Create;
  FShape.Brush.Color:=clBtnFace;
  FShape.OnChange:=GetChange;
  FColors.OnChange:=GetChange;
  FBtnFaceChangeLink.OnChange:=GetIMLFaceChange;
  FShapeFill.OnChange:=GetChange;
  Transparent:=False;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomShapeButton.Destroy;
begin
  FShape.OnChange:=nil;
  FColors.OnChange:=nil;
  FBtnFaceChangeLink.OnChange:=nil;
  FShapeFill.OnChange:=nil;
  FBtnFaceChangeLink.Free;
  FShape.Free;
  FBrush.Free;
  FColors.Free;
  FList.Free;
  FBitmap.Free;
  FShapeFill.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeButton.Paint;
var
  tempShadow: TLMDShadow;
  tempBevel: TLMDSimpleBevel;
  aRect: TRect;
  aBrush: TBrush;
  tempBrush: TBrush;
  temppict: TBitmap;
  Temp:TBitmap;
  tempDepth: TLMDShadowDepth;
begin
  if csLoading in ComponentState then
    Exit;

  aRect:=ClientRect;
  tempBevel:=nil;
  tempShadow:=nil;

  if FMode=sbmShapeFast then
  begin
    if not Transparent then
      FillControl
    else if (CheckOptimized) then
      BackDrawArea(Canvas, ClientRect, Point(0, 0), 0);

    aBrush:=TBrush.Create;
    try
      if Style=sbs3D then
        tempShadow:=nil
      else
        case FState of
          bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
          begin
            tempShadow:=TLMDShadow.Create;
            with tempShadow do
            begin
              Color:=Shape.Shadow.Color;
              Style:=Shape.Shadow.Style;
              Depth:=0;
            end;
          end;
        else
          tempShadow:=Shape.Shadow;
        end;

      if Style=sbs3D then {Bevel3D then}
      begin
        tempBevel:=TLMDSimpleBevel.Create;
        with tempBevel do
        begin
          LightColor:=Shape.Bevel.LightColor;
          ShadowColor:=Shape.Bevel.ShadowColor;
          Width:=Shape.Bevel.Width;
          case FState of
            bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
              Style:=sbInset;
          else
            Style:=sbOffset;
          end;
        end;
      end
      else
        tempBevel:=Shape.Bevel;

      case FState of
        bsUp:
          aBrush.Color:=FColors.Up;
        bsDown:
          aBrush.Color:=FColors.Down;
        bsMouseOver:
          aBrush.Color:=FColors.MouseOver;
        bsOptionSet,bsDropDownOpen:
          aBrush.Color:=FColors.OptionSet;
        bsDisabledUp,bsdisabledDown:
          aBrush.Color:=FColors.Disabled;
      end;

      with Shape do
      begin
        LMDShapeDraw(aRect,Canvas,Shape,nil,FList,Square,aBrush,
         RoundPercent,tempBevel,tempShadow,nil,Color,Color,0);
      end;

      with Shape.Shadow, Shape do
      begin
        aRect:=Rect(1+Bevel.Width,1+Bevel.Width,aRect.Right-(2*Bevel.Width)-Depth-1,
                     aRect.Bottom-(2*Bevel.Width)-Depth-1);

        if FState in [bsDown, bsOptionSet, bsDropDownOpen] then
          if (Self.Style=sbs3D) then
            OffsetRect(aRect,2,2)
          else
            OffsetRect(aRect,Depth,Depth);
      end;

      DrawGlyphAndText(Canvas, aRect);
    finally
      case FState of
        bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
          if tempShadow<>nil then tempShadow.Free;
      end;
      if Style=sbs3D then {Bevel3D then}
        if tempBevel<>nil then tempBevel.Free;
      aBrush.Free;
    end;
  end
  else
  begin
    tempBrush:=nil;
    tempDepth:=FShadowDepth;

     if FState in [bsDown, bsOptionSet, bsDropDownOpen, bsDisabledDown] then
     begin
       TempPict:=TBitmap.Create;
       TempPict.Width:=Self.Width;
       TempPict.Height:=Self.Height;
       if (FStyle=sbs3D) then
         TempPict.Canvas.Draw(2,2,FBitmap)
       else
         TempPict.Canvas.Draw(Shape.Shadow.Depth,Shape.Shadow.Depth,FBitmap)
     end
     else
       TempPict:=FBitmap;

    Temp:=TBitmap.Create;
    try
      Temp.Width:=Self.Width;
      Temp.Height:=Self.Height;
      if Style=sbs3D then
        tempShadow:=nil
      else
        case FState of
          bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
          begin
            tempShadow:=TLMDShadow.Create;
              with tempShadow do
              begin
                Color:=Shape.Shadow.Color;
                Style:=Shape.Shadow.Style;
                Depth:=0;
              end;
          end;
        else
          tempShadow:=Shape.Shadow;
        end;

      if Style=sbs3D then {Bevel3D then}
      begin
        tempBevel:=TLMDSimpleBevel.Create;
        with tempBevel do
        begin
          LightColor:=Shape.Bevel.LightColor;
          ShadowColor:=Shape.Bevel.ShadowColor;
          Width:=Shape.Bevel.Width;
          case FState of
            bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
              Style:=sbInset;
          else
            Style:=sbOffset;
          end;
        end;
        FShadowDepth:=0;
      end
      else
        tempBevel:=Shape.Bevel;

      with Shape.Shadow, Shape do
      begin
        aRect:=Rect(1+Bevel.Width,1+Bevel.Width,aRect.Right-(2*Bevel.Width)-Depth-1,
                     aRect.Bottom-(2*Bevel.Width)-Depth-1);
        if FState in [bsDown, bsOptionSet, bsDropDownOpen] then
          if (Self.Style=sbs3D) {and (Depth=0)} then
            OffsetRect(aRect,2,2)
          else
            OffsetRect(aRect,Depth,Depth);
      end;

      if CheckOptimized then
        BackDrawArea(temp.Canvas, ClientRect,Point(0,0), 0)
      else
      begin
        Temp.Canvas.Brush.Color:=Color;
        Temp.Canvas.FillRect(ClientRect);
      end;

      case FShapeFill.Style of
        sfGradient,sfBitmap, sfBitmapList:
        begin
           if FShapeFill.Style=sfGradient then
             FShapeFill.Gradient.SetRealPalette(Canvas);
            with FShape do
              LMDShapeDraw(ClientRect, Temp.Canvas, Shape, nil, FList, Square, Brush,
               RoundPercent, tempBevel, tempShadow, tempPict, Color, Color,0);
        end;
        sfBrush:
        begin
          temp.Canvas.Brush.Color:=Color;
          with FShape do
            LMDShapeDraw(ClientRect,temp.Canvas,Shape,nil,FList,Square,Brush,
                         RoundPercent,tempBevel,tempShadow,nil,Color,Color,0);
        end;
        sfNone, sfBrushBitmap:
        begin
          tempBrush:=TBrush.Create;
           case FShapeFill.Style of
            sfNone:         tempBrush.Style:=bsClear;
            sfBrushBitmap:  tempBrush.Bitmap:=FShapeFill.Bitmap;
          end;
          with FShape do
            LMDShapeDraw(ClientRect,temp.Canvas,Shape,nil,FList,Square,tempBrush,
             RoundPercent,tempBevel,tempShadow,nil,Color,Color,0);
        end;
      end;{case}

      SetBKMode(temp.Canvas.Handle, 0);
      DrawGlyphAndText(Temp.Canvas, aRect);
      if CheckOptimized or not Transparent then
        Canvas.Draw(0,0,Temp)
      else
        LMDBmpDrawExt(Canvas, ClientRect, temp.Canvas, ClientRect,
                      DSF_TRANSPARENCY or DSF_PALETTEREALIZE,
                      Color, GetPalette, nil);

    finally
      Temp.Free;
      if tempBrush<>nil then tempBrush.Free;
      case FState of
        bsDown,bsOptionSet,bsDisabledDown,bsDropDownOpen:
        begin
          if tempShadow<>nil then tempShadow.Free;
          if temppict<>nil then temppict.Free;
        end;
      end;
      if Style=sbs3D then {Bevel3D then}
        if tempBevel<>nil then tempBevel.Free;
    end;
    FShadowDepth:=tempDepth;
  end;
end;

end.
