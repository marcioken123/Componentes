unit LMDFXCaption;
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

LMDFXCaption unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  lmdgraph,
  LMD3DCaption;

type
  {adds Rotating and free Positioning}
  TLMDFxCaption = class(TLMD3DCaption)
  private
    FAngle:TLMDAngle;
    FPosX:WORD;
    FPosY:WORD;
    Procedure SetAngle(aValue:TLMDAngle);
    Procedure SetPos(Index:Integer; aValue:WORD);
  protected
  public
    constructor Create(AOwner: TPersistent = nil); override;
    procedure Assign(Source: TPersistent); override;
    function GetSetStr : String; override;
    procedure SetPosXY(X,Y:Word);
  published
    property Angle:TLMDAngle read FAngle write SetAngle default 0;
    property PosX:WORD index 0 read FPosX write SetPos default 0;
    property PosY:WORD index 1 read FPosY write Setpos default 0;
  end;

implementation

uses
  SysUtils;

{------------------------- Private --------------------------------------------}
procedure TLMDFxCaption.SetAngle(aValue:TLMDAngle);
begin
  if aValue<>FAngle then
    begin
      FAngle:=aValue;
      if FAngle=360 then FAngle:=0;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxCaption.SetPos(Index:Integer;aValue:WORD);
begin
  case Index of
    0:if FPosX=aValue then exit else FPosX:=aValue;
    1:if FPosY=aValue then exit else FPosY:=aValue;
  end;
  Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDFxCaption.Create;
begin
  inherited Create;
  FAngle:=0;
  FPosX:=0;
  FPosY:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxCaption.SetPosXY(X,Y:Word);
begin
  BeginUpdate;
  SetPos(0,X);
  SetPos(1,Y);
  EndUpdate(false);
end;

{------------------------------------------------------------------------------}
procedure TLMDFxCaption.Assign(source:TPersistent);
var
  S: TLMDFxCaption;
begin
  if source=self then exit;
  if Source is TLMDFxCaption then
    begin
      S := TLMDFxCaption(source);
      FDisabledStyle := S.DisabledStyle;
      FLightDepth:=S.LightDepth;
      FShadowDepth:=S.ShadowDepth;
      FLightColor:=S.LightColor;
      FShadowColor:=S.ShadowColor;
      FStyle:=S.Style;
      FPosX:=S.PosX;
      FPosy:=S.PosY;
      FAngle:=S.Angle;
      FTracing:=S.Tracing;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDFxCaption.GetSetStr : String;
begin
  result := inherited GetSetStr;
  if FAngle <> 0 then
    begin
      if result = '{Disabled}' then
        result := '{'
      else
        result[Length(result)] := ',';
      result := result + ' rot: '+IntToStr (FAngle)+'°}';
    end;
end;

end.
