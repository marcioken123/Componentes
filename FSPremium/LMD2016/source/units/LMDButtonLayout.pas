unit LMDButtonLayout;
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

LMDButtonLayout unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Graphics,
  LMDButtonBase,
  LMDGraph,
  LMDGlyphTextLayout;

type
  TLMDButtonLayout = class(TLMDGlyphTextLayout)
  private
    FArrow: Boolean;
    FArrowColor: TColor;
    FArrowIndent: Integer;
    FArrowPosition: TLMDArrowPosition;
    FArrowSize: TLMDDDArrowSize;
  protected
    procedure SetArrow(aValue: Boolean);
    procedure SetArrowColor(aValue: TColor);
    procedure SetArrowPosition(aValue: TLMDArrowPosition);
    procedure SetArrowSize(aValue: TLMDDDArrowSize);
    procedure SetInteger(Index: Integer; aValue:Integer);
  public
    constructor Create(AOwner: TPersistent = nil); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Alignment default agCenter;
    property Arrow: Boolean read FArrow write SetArrow default False;
    property ArrowColor: TColor read FArrowColor write SetArrowColor default clBlack;
    property ArrowIndent: Integer Index 0 read FArrowIndent write SetInteger default 3;
    property ArrowPosition: TLMDArrowPosition read FArrowPosition
                            write SetArrowPosition default apRightText;
    property ArrowSize: TLMDDDArrowSize read FArrowSize write SetArrowSize default 3;
  end;

implementation

{------------------------- Private --------------------------------------------}
procedure TLMDButtonLayout.SetArrow(aValue: Boolean);
begin
  if FArrow<>aValue then
    begin
      FArrow:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayout.SetArrowColor(aValue: TColor);
begin
  if FArrowColor<>aValue then
    begin
      FArrowColor:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayout.SetArrowPosition(aValue: TLMDArrowPosition);
begin
  if FArrowPosition<>aValue then
    begin
      FArrowPosition:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayout.SetArrowSize(aValue: TLMDDDArrowSize);
begin
  if FArrowSize<>aValue then
    begin
      FArrowSize:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayout.SetInteger(Index: Integer; aValue:Integer);
begin
  case index of
    0: if aValue<>FArrowIndent then FArrowIndent:=aValue else exit;
  end;
  Change;
end;

{------------------------- Protected ------------------------------------------}
constructor TLMDButtonLayout.Create;
begin
  inherited Create;
  FAlignment:=agCenter;
  FArrow:=False;
  FArrowColor:=clBlack;
  FArrowIndent:=3;
  FArrowPosition:=apRightText;
  FArrowSize:=3;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayout.Assign(Source: TPersistent);
var
  S: TLMDButtonLayout;
begin
  if Source=self then exit;
  if Source is TLMDButtonLayout then
    begin
      S := TLMDButtonLayout(Source);
      BeginUpdate;
      Alignment:=S.Alignment;
      AlignText2Glyph:=S.AlignText2Glyph;
      {F}OffsetX:=S.OffsetX;
      {F}OffsetY:=S.OffsetY;
      Spacing:=S.Spacing;

      FArrow:=S.Arrow;
      FArrowIndent:=S.ArrowIndent;
      FArrowPosition:=S.ArrowPosition;
      FArrowColor:=S.ArrowColor;
      FArrowSize:=S.ArrowSize;
      EndUpdate(True);
      Exit;
    end;
  inherited Assign(Source);
end;

end.
