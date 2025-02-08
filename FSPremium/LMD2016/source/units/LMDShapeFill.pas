unit LMDShapeFill;
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

LMDShapeFill unit (RM)
----------------------

Changes
-------
Release 10.0 (August 2010)
 + PNG support added

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, LMDGradient, LMDGraph, LMDObject, LMDPngImage;

type
  {----------------------TLMDShapeFill---------------------------------------}
  TLMDShapeFill = class(TLMDObject)
  private
    FBitmap : TBitmap;
    FPng: TLMDPNGObject;
    FGradient: TLMDGradient;
    FFillStyle: TLMDFillStyle;
    FTileMode: TLMDTileMode;
    procedure SetBitmap(aValue: TBitmap);
    procedure SetListBitmap(aValue:TBitmap);
    procedure SetGradient(aValue: TLMDGradient);
    procedure SetFillStyle(aValue: TLMDFillStyle);
    procedure SetTileMode(aValue: TLMDTileMode);
    function GetBitmap:TBitmap;
    function GetEmpty:Boolean;
    function GetMustRedraw:Boolean;
    function GetPalette:HPalette;
    procedure SetPng(const Value: TLMDPNGObject);
  protected
    FListBitmap: TBitmap;
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign(Source:TPersistent);override;
    function GetSetStr : String; override;
    property Empty:Boolean read GetEmpty;
    property Palette:HPalette read GetPalette;
    property SizeDependent:Boolean read GetMustRedraw;
    property ListBitmap:TBitmap read FListBitmap write SetListBitmap;
    property CurrentBitmap:TBitmap read GetBitmap;
  published
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Png: TLMDPNGObject read FPng write SetPng;
    property Style:TLMDFillStyle read FFillStyle write SetFillStyle default sfBrush;
    property Gradient:TLMDGradient read FGradient write SetGradient;
    property TileMode:TLMDTileMode read FTileMode write SetTileMode default tmTile;
  end;

implementation
uses
  TypInfo;
{------------------------- Private --------------------------------------------}
procedure TLMDShapeFill.SetBitmap(aValue: TBitmap);
begin
  FBitmap.assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFill.SetListBitmap(aValue: TBitmap);
begin
  FListBitmap.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFill.SetPng(const Value: TLMDPNGObject);
begin
  FPng.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFill.SetGradient(aValue: TLMDGradient);
begin
  FGradient.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFill.SetFillStyle(aValue: TLMDFillStyle);
begin
  if aValue<>FFillStyle then
    begin
      FFillStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeFill.SetTileMode(aValue: TLMDTileMode);
begin
  if aValue<>FTileMode then
    begin
      FTileMode:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShapeFill.GetBitmap:TBitmap;
begin
  result:=nil;
  case FFillStyle of
    sfBitmap:result:=FBitmap;
    sfBitmapList:result:=FListBitmap;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShapeFill.GetEmpty:Boolean;
begin
  result:=False;
  case FFillStyle of
    sfBitmap:result:=FBitmap.Empty;
    sfBitmapList:result:=FListBitmap.Empty;
    sfNone:result:=True;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShapeFill.GetMustRedraw:Boolean;
begin
  result:=True;
  case FFillStyle of
    sfBitmap, sfBitmapList:if FTileMode=tmTile then result:=False;
    sfBrushBitmap, sfBrush:result:=False;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShapeFill.GetPalette:HPalette;
begin
  result:=0;
  case FFillStyle of
    sfBrushBitmap,sfBitmap:result:=FBitmap.Palette;
    sfBitmapList:result:=FListBitmap.Palette;
    sfGradient:result:=FGradient.Palette;
  end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDShapeFill.Assign(Source:TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDShapeFill then
    begin
      BeginUpdate;
      FBitmap.Assign(TLMDShapeFill(Source).Bitmap);
      FListBitmap.Assign(TLMDShapeFill(Source).ListBitmap);
      FGradient.Assign(TLMDShapeFill(Source).Gradient);
      FFillStyle:=TLMDShapeFill(Source).Style;
      FTileMode:=TLMDShapeFill(Source).TileMode;
      EndUpdate(True);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDShapeFill.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDFillStyle), Ord(FFillStyle));
  result:='{'+Copy(result, 3, Length(result)-2)+'}';
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDShapeFill.Create;
begin
  inherited Create(nil);
  FPng := TLMDPNGObject.Create;
  FBitmap:=TBitmap.Create;
  FBitmap.OnChange:=GetChange;
  FListBitmap:=TBitmap.Create;
  FGradient:=TLMDGradient.Create;
  FGradient.OnChange:=GetChange;
  FFillStyle:=sfBrush;
  FTileMode:=tmTile;
end;

{------------------------------------------------------------------------------}
destructor TLMDShapeFill.Destroy;
begin
  FBitmap.OnChange:=nil;
  FBitmap.Free;
  FPng.Free;
  {if FListBitmap<>nil then }FListBitmap.Free;
  FGradient.OnChange:=nil;
  FGradient.Free;
  inherited Destroy;
end;

end.
 
