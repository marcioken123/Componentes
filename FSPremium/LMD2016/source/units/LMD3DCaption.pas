unit LMD3DCaption;
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

LMD3DCaption unit ()
--------------------

Object containing properties for several font effects

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
  TLMD3DCaption = class(TLMDObject)
  private
    Procedure SetDepth(Index:Integer; aValue:Byte);
    procedure SetDisabledStyle(aValue:TLMDDisabledStyle);
    Procedure SetColor(Index:Integer; aValue:TColor);
    Procedure SetStyle(aValue:TLMDThreeDStyle);
    Procedure SetOrientation(aValue:TLMDThreeDOrientation);
    procedure SetTracing(aValue: Integer);
  protected
    FDisabledStyle : TLMDDisabledStyle;
    FLightDepth,
    FShadowDepth   : Byte;
    FLightColor,
    FShadowColor   : TColor;
    FStyle         : TLMDThreedStyle;
    FOrientation   : TLMDThreeDOrientation;
    FTracing       : Integer;
  public
    constructor Create(Owner: TPersistent = nil); override;
    procedure Assign(Source: TPersistent); override;
    function GetSetStr : String; override;
  published
    property DisabledStyle:TLMDDisabledStyle read FDisabledStyle write SetDisabledStyle default dsAuto;
    property LightDepth:Byte index 0 read FLightDepth write SetDepth default 1;
    property ShadowDepth:Byte index 1 read FShadowDepth write SetDepth default 1;
    property LightColor:TColor index 0 read FLightColor write SetColor default clBtnHighlight;
    property Orientation:TLMDThreeDOrientation read FOrientation write SetOrientation default toTopLeft;
    property ShadowColor:TColor index 1 read FShadowColor write Setcolor default clBtnShadow;
    property Style:TLMDThreeDStyle read FStyle write SetStyle default tdNone;
    property Tracing: Integer read FTracing write SetTracing default 0;
  end;

implementation
uses
  TypInfo;

{------------------------- Private --------------------------------------------}
Procedure TLMD3DCaption.SetColor(Index:Integer;aValue:TColor);
begin
  case Index of
    0:if FLightColor=aValue then exit else FLightColor:=aValue;
    1:if FShadowColor=aValue then exit else FShadowColor:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
Procedure TLMD3DCaption.SetDisabledStyle(aValue:TLMDDisabledStyle);
begin
  if aValue<>FDisabledStyle then
    begin
      FDisabledStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMD3DCaption.SetDepth(Index:Integer; aValue:Byte);
begin
  case index of
    0:if aValue=FLightDepth then exit else FLightDepth:=aValue;
    1:if aValue=FShadowDepth then exit else FShadowDepth:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
Procedure TLMD3DCaption.SetStyle(aValue:TLMDThreeDStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMD3DCaption.SetOrientation(aValue:TLMDThreeDOrientation);
begin
  if aValue<>FOrientation then
    begin
      FOrientation:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DCaption.SetTracing(aValue: Integer);
begin
  if aValue<>FTracing then
    begin
      FTracing:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMD3DCaption.Create(Owner: TPersistent = nil);
begin
  inherited Create(Owner);
  FDisabledStyle:=dsAuto;
  FLightDepth:=1;
  FShadowDepth:=1;
  FLightColor:=clBtnHighlight;
  FShadowColor:=clBtnShadow;
  FStyle:=tdNone;
  FTracing:=0;
  FOrientation:=toTopLeft;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DCaption.Assign(source:TPersistent);
var
  S: TLMD3DCaption;
begin
  if source=self then exit;
  if Source is TLMD3DCaption then
    begin
      S := TLMD3DCaption(source);
      FDisabledStyle:=S.DisabledStyle;
      FLightDepth:=S.LightDepth;
      FShadowDepth:=S.ShadowDepth;
      FLightColor:=S.LightColor;
      FShadowColor:=S.ShadowColor;
      FStyle:=S.Style;
      FTracing:=S.Tracing;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMD3DCaption.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDThreedStyle), Ord(FStyle));
  result:='{'+Copy(result, 3, Length(result)-2)+'}';
end;

end.
