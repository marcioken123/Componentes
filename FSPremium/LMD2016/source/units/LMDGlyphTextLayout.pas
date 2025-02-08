unit LMDGlyphTextLayout;
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

LMDGlyphTextLayout unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDGraph,
  LMDObject;

type
  {----------------------TLMDGlyphTextLayout---------------------------------}
  TLMDGlyphTextLayout=class(TLMDObject)
  private
    FAlignText2Glyph: TLMDTextArrange;
    FOffsetX,
    FOffsetY: Integer;
    FSpacing: Integer;
  protected
    FAlignment: TLMDAlignment;
    procedure SetAlignment(aValue: TLMDAlignment);
    procedure SetAlignText2Glyph(aValue: TLMDTextArrange);
    procedure SetOffset(index: Integer; aValue: Integer);
    procedure SetSpacing(aValue:Integer);
  public
    constructor Create(Owner: TPersistent = nil); override;
    procedure Assign(Source: TPersistent); override;
    function GetSetStr : String; override;
  published
    //default value removed, JH March 2001, otherwise this value will not be stored
    //in controls needing another default value!!
    property Alignment: TLMDAlignment read FAlignment write SetAlignment{ default agTopLeft};
    property AlignText2Glyph: TLMDTextArrange read FAlignText2Glyph
                                              write SetAlignText2Glyph default taRight;
    property OffsetX: Integer index 0 read FOffsetX write SetOffset default 0;
    property OffsetY: Integer index 1 read FOffsetY write SetOffset default 0;
    property Spacing: Integer read FSpacing write SetSpacing default 2;
  end;

implementation

{------------------------- Protected ------------------------------------------}
procedure TLMDGlyphTextLayout.SetAlignment(aValue: TLMDAlignment);
begin
  if FAlignment<>aValue then
    begin
      FAlignment:=aValue;
      Change;
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayout.SetAlignText2Glyph(aValue: TLMDTextArrange);
begin
  if FAlignText2Glyph<>aValue then
    begin
      FAlignText2Glyph:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayout.SetOffset(index: Integer; aValue: Integer);
begin
  case index of
  0: if aValue=FOffsetX then exit else FOffsetX:=aValue;
  1: if aValue=FOffsetY then exit else FOffsetY:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayout.SetSpacing(aValue:Integer);
begin
  if aValue<>FSpacing then
    begin
      FSpacing:=aValue;
      Change;
    end;
end;

{------------------------- Protected ------------------------------------------}
constructor TLMDGlyphTextLayout.Create(Owner: TPersistent = nil);
begin
  inherited Create(Owner);
  FAlignment:=agTopLeft;
  FAlignText2Glyph:=taRight;
  FOffsetX:=0;
  FOffsetY:=0;
  FSpacing:=2;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayout.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDGlyphTextLayout then
    with  TLMDGlyphTextLayout(Source) do
      begin
        self.FAlignment:=Alignment;
        self.FAlignText2Glyph:=AlignText2Glyph;
        self.FOffsetX:=OffsetX;
        self.FOffsetY:=OffsetY;
        self.FSpacing:=Spacing;
        self.Change;
        Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDGlyphTextLayout.GetSetStr : String;
begin
  result := '';
end;

end.
