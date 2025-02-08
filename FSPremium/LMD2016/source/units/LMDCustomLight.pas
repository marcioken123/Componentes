unit LMDCustomLight;
{$I lmdcmps.Inc}

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

LMDCustomLight unit (RM)
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls,
  LMDBase, LMDClass, LMDBaseGraphicControl, LMDSimpleBevel, LMDCaption, LMDGraph,
  LMDPointList;

type

  {---------------------------- TLMDLight -------------------------------------}
  TLMDLightStyle = (ltRect, ltRound);

  TLMDCustomLight = class(TLMDBaseGraphicControl)
  private
    FActive: Boolean;
    FBevel: TLMDSimpleBevel;
    FColor: TLMDLightColor;
    FDraw:Boolean;
    FOnColor:TColor;
    FOffColor:TColor;
    FList: TLMDPointList;
    FStyle: TLMDLightStyle;
  protected
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    procedure Draw(PaintBorder: Boolean);
    procedure GetChange(Sender:TObject);override;
    procedure SetActive(aValue:Boolean);
    procedure SetBevel(aValue:TLMDSimpleBevel);
    procedure SetDraw(aValue:Boolean);
    procedure SetLightColor(aValue:TLMDLightColor);
    procedure SetStyle(aValue:TLMDLightStyle);
    procedure Paint;override;
    procedure Loaded;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Active:Boolean read FActive write SetActive default false;
  published
    property About;
    property Bevel: TLMDSimpleBevel read FBevel write SetBevel;
    property Color;
    property DrawExtended:Boolean read FDraw write SetDraw default false;
    property Enabled;
    property LightColor: TLMDLightColor read FColor write SetLightColor default lcRed;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style: TLMDLightStyle read FStyle write SetStyle default ltRound;
    property Transparent;
    Property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Types,
  LMDConst, LMDShape;

{************************ Class TLMDLight *************************************}
{----------------- Private ----------------------------------------------------}
procedure TLMDCustomLight.SetActive(aValue:Boolean);
begin
  if FActive <> aValue then
    begin
      FActive:=aValue;
      Draw(False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.SetBevel(aValue: TLMDSimpleBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.SetDraw(aValue:Boolean);
begin
  if FDraw <> aValue then
    begin
      FDraw:=aValue;
      if FStyle=ltRound then Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.SetLightColor(aValue:TLMDLightColor);
begin
  if FColor<>aValue then
    begin
      FColor:=aValue;
      LMDGetLightColors(FColor, FOnColor, FOffColor);
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.SetStyle(aValue: TLMDLightStyle);
begin
  if FStyle <> aValue then
  begin
    FStyle:=aValue;
    GetChange(nil);
  end;
end;

{--------------- Protected ----------------------------------------------------}
procedure TLMDCustomLight.BoundsChange(State:TLMDBoundsChangeStates);
begin
  if  (State=[bcPos]) or (Flist=nil) or (FBevel=nil) then exit;
  if FStyle=ltRound then
    LMDShapeCalc(ClientRect,stEllipse,nil,false,Canvas.Brush,0,FBevel,nil,FList)
  else
    LMDShapeCalc(ClientRect,stRectangle,nil,false,Canvas.Brush,0,FBevel,nil,FList);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.Draw(PaintBorder:Boolean);
var aRect:TRect;
    S:Integer;
begin

  aRect:=ClientRect;

  with Canvas do
    begin

      if (PaintBorder) and (not Transparent) and (FStyle=ltRound) then FillControl;

      if not Enabled then
        Brush.Color:=Color
      else
        if FActive then Brush.Color:=FOnColor else Brush.Color:=FOffColor;

      if FStyle=ltRound then
        with aRect do
          begin
            if Bevel.Style=sbNormal then
              begin
                Pen.Color:=Bevel.Color;
                Pen.Width:=Bevel.Width;
                if Bevel.Width=0 then
                  Pen.Style:=psClear
                else
                  Pen.Style:=psInsideFrame;
                Ellipse(Left,Top,Right,Bottom);
                {Ellipse(Left+(FBevel.Width),Top+(FBevel.Width),
                    Right-(FBevel.Width),Bottom-(FBevel.Width));}
              end
           else
              begin
                Pen.Style:=psSolid;
                {Brush.Style:=bsClear;}
                LMDShapeDraw(ClientRect,Canvas,stEllipse,nil,
                             FList,false,Brush,0,FBevel,nil,
                             nil,Color,clBlack,0);
                Brush.Style:=bsSolid;
              end;

            Pen.Style:=psSolid;
            Pen.Width:=1;

            if FActive and Enabled then Pen.Color:=clSilver else Pen.Color:=clGray;

            if FDraw then
              begin
                S:=Width div 6;
                Arc(Left + S,Top + S, Right - S,Bottom - S,
                    Right - S,Top + S, Left + S,Bottom - S);
              end;
          end
      else
        if PaintBorder then
          begin
            Brush.Style:=bsSolid;
            LMDShapeDraw(ClientRect,Canvas,stRectangle,nil,
                         FList,false,Brush,0,FBevel,nil,
                         nil,Color,clBlack,0);
          end
        else
          with aRect do
            FillRect(Rect(Left+(FBevel.Width),Top+(FBevel.Width),
                    Right-(FBevel.Width),Bottom-(FBevel.Width)));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.GetChange(Sender:TObject);
begin
  if FStyle=ltRound then
    LMDShapeCalc(ClientRect,stEllipse,nil,false,Canvas.Brush,0,FBevel,nil,FList)
  else
    LMDShapeCalc(ClientRect,stRectangle,nil,false,Canvas.Brush,0,FBevel,nil,FList);
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.Loaded;
begin
  inherited Loaded;
  LMDShapeCalc(ClientRect,stEllipse,nil,false,Canvas.Brush,0,FBevel,nil,FList);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLight.Paint;
begin
  Draw(True);
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDCustomLight.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Brush.Style:=bsSolid;
  Canvas.Pen.Width:=1;

  FBevel:=TLMDSimpleBevel.Create;
  FList:=TLMDPointList.Create;

  FColor:=lcRed;
  FOnColor:=clRed;
  FOffColor:=clMaroon;

  FActive:=False;
  FStyle:=ltRound;

  FBevel.OnChange:=GetChange;
  ControlStyle := ControlStyle + [csReplicatable];
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomLight.Destroy;
begin
  FBevel.OnChange:=nil;
  OnBoundsChange:=nil;

  FBevel.Free;
  FList.Free;

  inherited Destroy;
end;

end.
