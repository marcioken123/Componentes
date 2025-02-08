unit LMDShadow;
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

LMDShadow unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics,
  LMDGraph, LMDObject;

type
  TLMDShadow = class(TLMDObject)
    private
      FColor : TColor;
      FDepth : TLMDShadowDepth;
      procedure SetColor(AValue:TColor);
      procedure SetDepth(AValue:TLMDShadowDepth);
      procedure SetStyle(AValue:TLMDShadowStyle);
    protected
      FStyle : TLMDShadowStyle;
    public
      constructor Create(Owner:TPersistent=nil);override;
      procedure Assign(Source:TPersistent);override;
      function GetSetStr : String; override;
    published
      property Color:TColor read FColor write SetColor default clBtnShadow;
      property Depth:TLMDShadowDepth read FDepth write SetDepth default 6;
      property Style:TLMDShadowStyle read FStyle write SetStyle default hssSolid;
  end;

implementation
uses
  SysUtils, TypInfo;

{------------------------- Private --------------------------------------------}
Procedure TLMDShadow.SetColor(aValue:TColor);
begin
  if aValue<>FColor then
    begin
      FColor:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDShadow.SetDepth(aValue:TLMDShadowDepth);
begin
  if aValue<>FDepth then
    begin
      FDepth:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDShadow.SetStyle(aValue:TLMDShadowStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDShadow.Create;
begin
  inherited Create;
  FColor:=clBtnShadow;
  FStyle:=hssSolid;
  FDepth:=6;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadow.Assign(Source:TPersistent);
begin
  if Source=Self then exit;
  if Source is TLMDShadow then
    begin
      FStyle:=TLMDShadow(Source).Style;
      FColor:=TLMDShadow(Source).Color;
      FDepth:=TLMDShadow(Source).Depth;
      Change;
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDShadow.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDShadowStyle), Ord(FStyle));
  result:='{'+Copy(result, 3, Length(result)-2);
  if FStyle<>hssNone then
    result:=result+', '+IntToStr (FDepth);
  result:=result+'}';
end;

end.
