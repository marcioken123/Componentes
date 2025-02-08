unit LMDCustomGraphicLabel;
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

LMDCustomGraphicLabel unit (JH, RM)
----------------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Messages, Classes, Controls,
  LMDGrLf, LMDGraph, LMDFillObject, LMDFXCaption, LMDGraphicControl, LMDCustomImageList;

type
  {-------------------------- TLMDGraphicLabel --------------------------------}
  TLMDCustomGraphicLabel = class(TLMDGraphicControl)
  private
    FToggle : TLMDToggle; { positive: toggles letters in tenth of degree left
                            negative: toggles letters in tenth of degree right }
    FFontFX : TLMDFXCaption;
    FPerspectiveDepth,
    FFactor : Integer;
    FTransform : TLMDTransLabelTypes;
    FTransAttr : TLMDTransLabelAttr;
    FPerspective : TLMDPerspective;
    FInvertCaption,
    FAutoSize : Boolean;
    FFillObject : TLMDFillObject;
    FBrushBack  : TColor;
    procedure SetBrushBack(aValue:TColor);
    procedure SetToggle (Value : TLMDToggle);
    procedure SetInteger (Index, Value: Integer);
    procedure SetBoolean (Index : Integer; Value : Boolean);
    procedure SetFontFX (Value : TLMDFXCaption);
    procedure SetTransform (Value : TLMDTransLabelTypes);
    procedure SetTransAttr (Value : TLMDTransLabelAttr);
    procedure SetPerspective (Value : TLMDPerspective);
    procedure SetFillObject (Value : TLMDFillObject);
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
    procedure CMTextChanged(var Message:TMessage);message CM_TEXTCHANGED;
  protected
    procedure GetChange(Sender: TObject);override;
    procedure GetIMLChange(Sender:TObject); override;
    function GetLabelText:String;virtual;
    function GetPalette:HPalette; override;
    procedure Paint; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source:TPersistent); override;    
  published
    property About;
    property Align;
    property Bevel;
    property BrushBackColor: TColor read FBrushBack write SetBrushBack default clBtnFace;
    property Font;
    property Toggle : TLMDToggle read FToggle write SetToggle default 0;
    property FontFX : TLMDFXCaption read FFontFX write SetFontFX;
    property Factor : Integer index 2 read FFactor write SetInteger default 5;
    property Transform : TLMDTransLabelTypes read FTransform write SetTransform default tmWave;
    property Attributes : TLMDTransLabelAttr read FTransAttr write SetTransAttr default [taAutoToggled];
    property Perspective : TLMDPerspective read FPerspective write SetPerspective default tpBird;
    property PerspectiveDepth : Integer index 4 read FPerspectiveDepth write SetInteger default 5;
    property AutoSize : Boolean index 1 read FAutoSize write SetBoolean default false;
    property InvertCaption : Boolean index 2 read FInvertCaption write SetBoolean default false;
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Color;
    property ParentColor;
    property ParentFont;
    property Transparent default false;
    { events }
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
    {4.0}
    //properties
    property Anchors;
    //property BiDiMode;
    property DragKind;
    property Constraints;
    //property ParentBiDiMode;
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
  Types,
  LMDBase, LMDProcs, LMDGraphUtils, LMDCont, LMDClass;

{******************** Class TLMDCustomGraphicLabel ****************************}
{-----------------------------Private------------------------------------------}
procedure TLMDCustomGraphicLabel.SetInteger (Index, Value : Integer);
begin
  Case Index Of
    2 : If FFactor <> Value Then Begin FFactor := Value; GetChange(nil); End;
    4 : If FPerspectiveDepth <> Value Then
          Begin
            FPerspectiveDepth := Value;
            If taPerspective in FTransAttr Then
              GetChange(nil);
          End;
  end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetBoolean (Index : Integer; Value : Boolean);
begin
  Case Index Of
    1 : If FAutoSize <> Value Then Begin FAutoSize := Value; GetChange(nil); End;
    2 : If FInvertCaption <> Value Then Begin FInvertCaption := Value; GetChange(nil); End;
  end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetTransform (Value : TLMDTransLabelTypes);
begin
  If Value <> FTransform Then
    begin
      FTransform := Value;
      GetChange(nil);
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetTransAttr (Value : TLMDTransLabelAttr);
begin
  If FTransAttr <> Value Then
    begin
      FTransAttr := Value;
      GetChange(nil);
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetPerspective (Value : TLMDPerspective);
begin
  If FPerspective <> Value Then
    begin
      FPerspective := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetBrushBack(aValue:TColor);
begin
  if FBrushBack<>aValue then
    begin
      FBrushBack:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetToggle (Value : TLMDToggle);
begin
  If FToggle <> Value Then
    begin
      FToggle := Value;
      If taToggled In FTransAttr Then
        GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomGraphicLabel.SetBevel (Value : TLMDBevel);
begin
  FBevel.Assign (Value);
end;}

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetFillObject (Value : TLMDFillObject);
begin
  FFillObject.Assign (Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.SetFontFX (Value : TLMDFXCaption);
begin
  FFontFX.Assign (Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.CMTextChanged(var Message: TMessage);
begin
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GetChange(Font);
end;

{-------------------------------Protected--------------------------------------}
procedure TLMDCustomGraphicLabel.Assign(Source:TPersistent);
var
  S: TLMDCustomGraphicLabel;
begin
  if Source=self then exit;
  if Source is TLMDCustomGraphicLabel then
    begin
      S := TLMDCustomGraphicLabel(Source);
      FAutoSize := False; { to prevent flicker }
      FFontFX.Assign(S.FontFX);
      Font.Assign(S.Font);
      FFillObject.Assign(S.FillObject);
      FTransAttr := S.Attributes;
      FPerspective := S.Perspective;
      FTransform := S.Transform;
      FPerspectiveDepth := S.PerspectiveDepth;
      FToggle := S.Toggle;
      FFactor := S.Factor;
      FAutosize:=S.AutoSize;
      GetChange(nil);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.GetChange(Sender: TObject);
var
  aRect : TRect;
begin
  if (csLoading in ComponentState) or (Parent = nil) then exit;
  If FAutoSize Then
    begin
      CalcSize        (Canvas, aRect, Font, FFontFX,
                       Caption, FTransform, FToggle, FFactor,
                       FInvertCaption, FPerspective, FPerspectiveDepth,
                       FTransAttr);
      SetBounds (Left,Top,aRect.Right+DblBevelExt, aRect.Bottom+DblBevelExt);
    end;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomGraphicLabel.GetPalette:HPalette;
begin
  result:=FFillObject.Palette;
end;

{------------------------------------------------------------------------------}
function TLMDCustomGraphicLabel.GetLabelText:String;
begin
  result:=Caption
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  if csLoading in ComponentState then exit;
  inherited GetIMLChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGraphicLabel.Paint;
var
  aRect,
  bRect         : TRect;
  FPaintCanvas,
  FBitmap       : TBitmap;
  Text          : String;

begin
  if (csLoading in ComponentState) or Painting then exit;

  If (caption = '') then inherited paint;

  if not Transparent then
    FillControl;

  //aRect:=ClientRect;
  aRect:=Bevel.PaintBevel(Canvas, ClientRect, (Bevel.BorderColor=Color) or Transparent);

  Text:=GetLabelText;
  If not FillObject.Empty then { paints fillobject }
    begin
      FPaintCanvas := TBitmap.Create;
      try
        LMDBmpCreateFromRect(FPaintCanvas, aRect, FBrushBack);
        FPaintCanvas.PixelFormat:=pf24Bit;  // workarounds error with ATI drivers in 32bit mode
        bRect:=Rect(0,0, FPaintCanvas.Width, FPaintCanvas.Height);

        SpecialTextOut  (FPaintCanvas.Canvas, aRect, Font, FFontFX,
                         Text, FTransform, FToggle, FFactor,
                         FInvertCaption, FPerspective, FPerspectiveDepth,
                         FTransAttr);

        FBitmap:=TBitmap.Create;
        try
          FBitmap.Width:=bRect.Right;
          FBitmap.Height:=aRect.Bottom;
          if FFillObject.Style=sfBrush then
            FFillObject.FillCanvas(FBitmap.Canvas, bRect, FBrushBack)
          else
            FFillObject.FillCanvas(FBitmap.Canvas, bRect, Font.Color);

          LMDMaskBmpDraw(Self.Canvas, aRect, FPaintCanvas, FBitmap, Font.Color, FBrushBack);
        finally
          FBitmap.Free;
        end;
      finally
        FPaintCanvas.Free;
      end;
    end
  else { paints pure text }
    begin
      Canvas.Font:=Font;
      SpecialTextOut  (Canvas, aRect, Font, FFontFX,
                       Caption, FTransform, FToggle, FFactor,
                       FInvertCaption, FPerspective, FPerspectiveDepth,
                       FTransAttr);
    end;
end;

{--------------------------------Public----------------------------------------}
constructor TLMDCustomGraphicLabel.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  DisableTransMode;
  FTransAttr := [taAutoToggled];
  FTransform := tmWave;
  FPerspective := tpBird;
  FPerspectiveDepth := 5;
  FFactor := 5;
  FFontFX := TLMDFXCaption.Create;
  FFontFX.OnChange := GetChange;
  FFillObject := TLMDFillObject.Create;
  FFillObject.OnChange := GetChange;
  FAutoSize := false;
  FInvertCaption := false;
  FBrushBack:=clBtnFace;
  Painting:=True;
//  Height:=48;
//  Width:=350;
  Font.Name := LMD_DEFAULTFONT;
  Font.Size := 24;
  Painting:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomGraphicLabel.Destroy;
begin
  FFontFX.OnChange := nil;
  FFontFX.Free;
  FFillObject.OnChange := nil;
  FFillObject.Free;
  inherited destroy;
end;

end.
