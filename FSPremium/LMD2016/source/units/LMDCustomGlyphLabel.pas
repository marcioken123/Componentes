unit LMDCustomGlyphLabel;
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

LMDCustomGlyphLabel unit (RM)
-----------------------------
Base class for labels with glyphs

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls,
  LMDGraph, LMDBevel, LMDGlyphTextLayout, LMD3DCaption, LMDBaseLabel;

type
  { ------------------------- class TLMDCustomGlyphLabel --------------------------- }
  TLMDCustomGlyphLabel = class(TLMDBaseLabel)
  private
    FGlyphTextLayout : TLMDGlyphTextLayout;
    FFont3D          : TLMD3DCaption;
    FBevel           : TLMDBevel;
    FGlyphNumber,
    FGlyphColumn     : Byte;
    procedure SetGlyphText (aValue : TLMDGlyphTextLayout);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetGlyphColumn(const Value: Byte);
    procedure SetGlyphNumber(const Value: Byte);
  protected
    function GetPalette:HPalette; override;
    function GetStatusControl: Boolean;override;
    procedure Paint; override;
    property GlyphNumber:Byte read FGlyphNumber write SetGlyphNumber default 1;
    property GlyphColumn:Byte read FGlyphColumn write SetGlyphColumn default 0;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure CorrectBounds; override;
    property Alignment: TLMDGlyphTextLayout read FGlyphTextLayout write SetGlyphText;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
  end;

implementation

uses
  Types, Graphics,
  LMDCustomStatusBar, LMDUtils, LMDCont, LMDGraphUtils, LMDCustomImageList;

{ ************************* class TLMDCustomGlyphLabel *********************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomGlyphLabel.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomGlyphLabel.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomGlyphLabel.SetGlyphColumn(const Value: Byte);
begin
   if (Value<>FGlyphColumn) and (Value<FGlyphNumber) then
    begin
      FGlyphColumn := Value;
      if ImageList<>nil then GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGlyphLabel.SetGlyphNumber(const Value: Byte);
begin
  if (Value<>FGlyphNumber) and (Value>0) then
    begin
      FGlyphNumber := Value;
      if FGlyphColumn>=FGlyphNumber then
        FGlyphColumn:=FGlyphNumber-1;
      if ImageList<>nil then GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomGlyphLabel.SetGlyphText (aValue : TLMDGlyphTextLayout);
begin
  FGlyphTextLayout.Assign(aValue);
end;

{ --------------------------------- Protected -------------------------------- }
procedure TLMDCustomGlyphLabel.CorrectBounds;
var
  aRect, bRect : TRect;
  flags:LongInt;

begin
  if (Align=alNone) and AutoSize and not (csLoading in ComponentState) then
    begin
      aRect:=ClientRect;
      flags:=0;
      flags:=DrawTextBiDiModeFlags(flags);
      LMDDrawTextCalcExt(Canvas, GetLabelText, FFont3D, aRect, Font, MultiLine,
                         ShowAccelChar, Bevel.BevelExtend, flags);
      if (Parent is TLMDCustomStatusBar) then
        aRect.Right := aRect.Right+TLMDCustomStatusBar(parent).GetControlGap;

      if not IMLEmpty then
        begin
          bRect := LMDIMLItemRect(ImageList, ListIndex, ImageIndex);
          if FGlyphNumber>1 then
            begin
              bRect.Right := bRect.Left + ((bRect.Right-bRect.Left) div FGlyphNumber);
            end;
        end
      else
        bRect := Rect (0,0,0,0);

      case FGlyphTextLayout.AlignText2Glyph of
         taRight, taLeft,taRightTop, taLeftTop:
           begin
              Inc (aRect.Right, (bRect.Right-bRect.Left)+FGlyphTextLayout.Spacing);
              if aRect.Top < bRect.Top then
                aRect.Top := bRect.Top;
               if aRect.Bottom<bRect.Bottom then
                 aRect.Bottom:=bRect.Bottom;
            end;
         taTop, taTopLeft, taBottom, taBottomLeft:
           begin
             Inc (aRect.Bottom, bRect.Bottom+FGlyphTextLayout.Spacing);
             if aRect.Right < bRect.Right - bRect.Left then
               aRect.Right := bRect.Right - bRect.Left;
           end;
      end; { end of case }
      Inc (aRect.Right, FGlyphTextLayout.OffsetX);
      Inc (aRect.Bottom, FGlyphTextLayout.OffsetY);
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomGlyphLabel.GetPalette: HPALETTE;
begin
  Result:=0;
  if not IMLEmpty then
    result:=LMDIMLPalette(ImageList, ListIndex);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomGlyphLabel.GetStatusControl: Boolean;
begin
  result:=true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomGlyphLabel.Paint;
var
  aBitmap:TBitmap;
  aRect,
  bRect:TRect;
  flags:LongInt;
  Text:String;

   // July 2008
  function CorrectRect(const Value:TRect):TRect;
  var
    w:Integer;
  begin
    w:=(Value.Right-value.Left) div FGlyphNumber;
    result:=Rect((FGlyphColumn*w), Value.Top, ((FGlyphColumn+1)*w), Value.Bottom);
  end;

begin
  Text:=GetLabelText;

  if not Transparent then FillControl;

  aRect:=GetClientRect;
  if (parent is TLMDCustomStatusBar) then
    aRect.Left := aRect.Left+(parent as TLMDCustomStatusBar).GetControlGap;

  {If Bevel-Settings - draw them!}
  if Bevel.BevelExtend<>0 then
  begin
    aRect:=Bevel.PaintBevel(Canvas, aRect, (Bevel.BorderColor=Color) or Transparent);
  end;

  Canvas.Brush.Color:=Color;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := GetThemedTextColor;

  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);

  aBitmap := TBitmap.Create;
  try
    if not IMLEmpty then
    begin
      LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, aBitmap);
      if FGlyphNumber>1 then
      begin
        bRect := LMDIMLItemRect(ImageList, ListIndex, ImageIndex);

        bRect := CorrectRect(bRect);
        LMDDrawTextAndGlyphExt(Canvas, Text, Font3D, aRect, aBitmap.Canvas,
                               bRect, nil, LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                               FGlyphTextLayout, Multiline, ShowAccelChar, Transparent,
                                [TLMDDrawTextStyle(Enabled), dtRectClip], flags);
        Exit;
      end;
    end;
    LMDDrawTextAndGlyph(Canvas, Text, FFont3D, aRect, aBitmap, nil,
                        FGlyphTextLayout, MultiLine, ShowAccelChar, Transparent,
                        [TLMDDrawTextStyle(Enabled), dtRectClip {RM, 7.01}], flags);
  finally
    aBitmap.Free;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDCustomGlyphLabel.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;
  FBevel := TLMDBevel.Create;
  FBevel.OnChange := GetChange;
  FGlyphTextLayout := TLMDGlyphTextLayout.Create;
  FGlyphTextLayout.OnChange := GetChange;
  FGlyphColumn:=0;
  FGlyphNumber:=1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomGlyphLabel.Destroy;
begin
  FGlyphTextLayout.OnChange := nil;
  FGlyphTextLayout.Free;
  FBevel.OnChange := nil;
  FBevel.Free;
  FFont3D.OnChange := nil;
  FFont3D.Free;
  inherited Destroy;
end;

end.
 
