unit LMDSmallBar;
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

LMDSmallBar unit (RM)
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Classes,
  LMDGraph, LMDObject;

type
  TLMDSmallBar = class(TLMDObject)
    private
      FAutosize:Boolean;
      FBarCount:byte;
      FColor:TColor;
      FHSpace:Byte;
      FVSpace:Byte;
      Procedure SetAutosize(aValue:Boolean);
      procedure SetByte(Index:Integer; aValue:Byte);
      procedure SetColor(aValue:TColor);
    public
      constructor Create(Owner:TPersistent=nil);override;
      procedure Assign(Source:TPersistent);override;
      function GetBarExtend(Direction:TLMDMeterDirection; w,h:Integer):Integer;
    published
      property AutoSize:Boolean read FAutosize write SetAutosize default True;
      property BarColor:TColor read FColor write SetColor default clNavy;
      property BarCount:Byte index 0 read FBarCount write SetByte default 10;
      property HSpace:Byte index 1 read FHSpace write SetByte default 3;
      property VSpace:Byte index 2 read FVSpace write SetByte default 3;
  end;

implementation

{------------------------- Private --------------------------------------------}
Procedure TLMDSmallBar.SetAutosize(aValue:Boolean);
begin
  if aValue<>FAutosize then
    begin
      FAutosize:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDSmallBar.SetByte(Index:Integer; aValue:Byte);
begin
  case index of
    0:if FBarCount=aValue then exit else begin FBarCount:=aValue end;
    1:if FHSpace=aValue then exit else FHSpace:=aValue;
    2:if FVSpace=aValue then exit else FVSpace:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
Procedure TLMDSmallBar.SetColor(aValue:TColor);
begin
  if aValue<>FColor then
    begin
      FColor:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDSmallBar.Create;
begin
  inherited Create;
  FBarCount:=10;
  FHSpace:=3;
  FVSpace:=3;
  FColor:=clNavy;
  FAutosize:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBar.Assign(Source:TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDSmallBar then
    begin
      FBarCount:=TLMDSmallBar(Source).BarCount;
      FHSpace:=TLMDSmallBar(Source).HSpace;
      FVSpace:=TLMDSmallBar(Source).VSpace;
      FColor:=TLMDSmallBar(Source).BarColor;
      FAutosize:=TLMDSmallBar(Source).AutoSize;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDSmallBar.GetBarExtend(Direction:TLMDMeterDirection; w,h:Integer):Integer;
var
  lBarCount:Integer;
begin
  result:=0;
  lBarCount := FBarCount;
  if lBarCount = 0 then lBarCount := 1;
  case Direction of
    mdHorizontal, mdHorizontalReverse:
     result:=Trunc((w-(FBarcount*FHSpace))/lBarCount);
    mdVertical, mdVerticalReverse:
      result:=Trunc((h-(FBarcount*FVSpace))/lBarCount);
  end;
end;

end.
 
