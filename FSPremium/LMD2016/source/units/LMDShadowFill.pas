unit LMDShadowFill;
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

LMDShadowFill unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Windows,
  Graphics,
  LMDGraphicControl;

type
  {------------------------- TLMDShadowFill -----------------------------------}
  TLMDShadowFillStyle=(sfNone, sfShadow, sfFullShadow);

  TLMDShadowFill=class(TLMDGraphicControl)
  private
    FShadowColor:TColor;
    FBrushBitmap:TBitmap;
    FFillMode:TLMDShadowFillStyle;
    procedure SetColor(aColor:TColor);
    procedure SetShadowMode(aValue:TLMDShadowFillStyle);
  protected
    function GetEmpty:Boolean;override;
    public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
    procedure Paint; override;
    published
    property About;
    property Align;
    property Bevel;
    property ParentShowHint;
    property ShadowColor:TColor read FShadowColor write SetColor default clBlack;
    property ShowHint;
    property Style:TLMDShadowFillStyle read FFillMode write SetShadowMode default sfShadow;
    property Visible;

    property Anchors;
    property Constraints;
  end;

implementation

uses
  Types, 
  LMDGraphUtils, LMDClass;

{--------------------- Private ------------------------------------------------}
procedure TLMDShadowFill.SetColor(aColor:TColor);
begin
  if aColor<>FShadowColor then
    begin
      if aColor=clWhite then aColor:=clBlack;
      FShadowColor:=aColor;
      FBrushBitmap.Assign(LMDApplication.GetBrushBitmap(FShadowColor));
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowFill.SetShadowMode(aValue:TLMDShadowFillStyle);
begin
  if aValue<>FFillMode then
    begin
      FFillMode:=aValue;
      InvalidateControl;
    end;
end;

{--------------------- protected ----------------------------------------------}
function TLMDShadowFill.GetEmpty:Boolean;
begin
  result:=(Bevel.BevelExtend=0) and (FFillMode=sfNone);
end;

{--------------------- Public -------------------------------------------------}
constructor TLMDShadowFill.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FShadowColor:=clBlack;

  FBrushBitmap:=TBitmap.Create;
  FBrushBitmap.Assign(LMDApplication.PatternBitmap);
  FFillMode:=sfShadow;
end;

{------------------------------------------------------------------------------}
destructor TLMDShadowFill.Destroy;
begin
  FBrushBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowFill.Paint;
var
  aRect:TRect;
begin
  if GetEmpty then
    begin
      inherited Paint;
      exit;
    end;

  aRect:=Bevel.PaintBevel(Canvas, GetClientRect, Transparent);
  case FFillMode of
    sfShadow:
      LMDFillPattern(Canvas.Handle, aRect, FBrushBitmap);
    sfFullShadow:
      LMDFillPattern(Canvas.Handle, Rect(0,0, Width+1, Height+1), FBrushBitmap);
  end;
end;

end.
