unit LMDSimpleBevel;
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

LMDSimpleBevel unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics,
  Classes,
  LMDGraph,
  LMDObject;

type
  TLMDSimpleBevelStyle=(sbNormal, sbInset, sbOffset);

  TLMDSimpleBevel = class(TLMDObject)
    private
      FWidth:TLMDBevelWidth;
      FStyle:TLMDSimpleBevelStyle;
      FColor,
      FLightColor,
      FShadowColor:TColor;
      procedure SetWidth(aValue: TLMDBevelWidth);
      procedure SetStyle(aValue: TLMDSimpleBevelStyle);
      procedure SetColor(Index: Integer; aValue: TColor);
    public
      constructor Create(Owner:TPersistent=nil);override;
      procedure Assign(Source:TPersistent);override;
      function GetSetStr : String; override;
    published
      property Color: TColor index 2 read FColor write SetColor default clBlack;
      property Width: TLMDBevelWidth read FWidth write SetWidth default 2;
      property Style: TLMDSimpleBevelStyle read FStyle write SetStyle default sbNormal;
      property LightColor: TColor index 0 read FLightColor write SetColor default clBtnHighLight;
      property ShadowColor: TColor index 1 read FShadowColor write SetColor default clBtnShadow;
  end;

implementation
uses
  TypInfo;
{------------------------- Private --------------------------------------------}
procedure TLMDSimpleBevel.SetWidth(aValue: TLMDBevelWidth);
begin
  if FWidth<>aValue then
    begin
      FWidth:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevel.SetStyle(aValue: TLMDSimpleBevelStyle);
begin
  if FStyle<>aValue then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevel.SetColor(Index: Integer; aValue: TColor);
begin
  case Index of
    0: if FLightColor=aValue then exit else FLightColor:=aValue;
    1: if FShadowColor=aValue then exit else FShadowColor:=aValue;
    2: if FColor=aValue then exit else FColor:=aValue;
  end;
  Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDSimpleBevel.Create;
begin
  inherited Create;
  FColor:=clBlack;
  FLightColor:=clBtnHighLight;
  FShadowColor:=clBtnShadow;
  FWidth:=2;
  FStyle:=sbNormal;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevel.Assign(Source:TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDSimpleBEvel then
    begin
      FColor:=TLMDSimpleBevel(Source).Color;
      FLightColor:=TLMDSimpleBevel(Source).LightColor;
      FShadowColor:=TLMDSimpleBevel(Source).ShadowColor;
      FWidth:=TLMDSimpleBevel(Source).Width;
      FStyle:=TLMDSimpleBevel(Source).Style;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDSimpleBevel.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDSimpleBevelStyle), Ord(FStyle));
  result:='{'+Copy(result, 3, Length(result)-2)+'}';
end;

end.
