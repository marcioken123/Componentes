unit LMDTeeth;
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

LMDTeeth unit ()
----------------

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
  TLMDTeethCount=0..50;
  {----------------------TLMDTeeth-------------------------------------------}
  TLMDTeeth = class(TLMDObject)
    private
      FCount: TLMDTeethCount;
      FDirection: TLMDDirection;
      FOffset,
      FSetPerCount: Boolean;
      FWidth,
      FHeight: Integer;

      procedure SetBoolean(Index: Integer; aValue: Boolean);
      procedure SetCount(aValue: TLMDTeethCount);
      procedure SetDirection(aValue: TLMDDirection);
      procedure SetInteger(Index: Integer; aValue:Integer);
    public
      constructor Create(Owner:TPersistent=nil);override;
      procedure Assign(Source: TPersistent); override;
    published
      Property Count: TLMDTeethCount read FCount write SetCount default 10;
      Property Direction: TLMDDirection read FDirection write SetDirection default tdRight;
      Property Height: Integer Index 1 read FHeight write SetInteger default 0;
      Property Offset: Boolean index 0 read FOffset write SetBoolean default True;
      Property SetPerCount: Boolean index 1 read FSetPerCount write SetBoolean default True;
      Property Width: Integer Index 0 read FWidth write SetInteger default 10;
  end;

implementation

{------------------------- Private --------------------------------------------}
procedure TLMDTeeth.SetBoolean(Index: Integer; aValue: Boolean);
begin
  case Index of
    0: if aValue=FOffset then exit else FOffset:=aValue;
    1: if aValue=FSetPerCount then exit else FSetPerCount:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeeth.SetDirection(aValue: TLMDDirection);
begin
  if aValue<>FDirection then
    begin
      FDirection:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeeth.SetInteger(Index: Integer; aValue: Integer);
begin
  case Index of
    0: if aValue=FWidth then exit else FWidth:=aValue;
    1: if aValue=FHeight then exit else FHeight:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeeth.SetCount(aValue: TLMDTeethCount);
begin
  if aValue<>FCount then
    begin
      FCount:=aValue;
      Change;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDTeeth.Create;
begin
  inherited Create;

  FCount:=10;
  FDirection:=tdRight;
  FOffset:=True;
  FSetPerCount:=True;
  FWidth:=10;
  FHeight:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeeth.Assign(Source: TPersistent);
begin
  if Source=Self then exit;
  if Source is TLMDTeeth then
    begin
      FDirection:=TLMDTeeth(Source).Direction;
      FCount:=TLMDTeeth(Source).Count;
      FWidth:=TLMDTeeth(Source).Width;
      FHeight:=TLMDTeeth(Source).Height;
      FSetPerCount:=TLMDTeeth(Source).SetPerCount;
      FOffset:=TLMDTeeth(Source).Offset;
      Change;
      exit;
    end;
  inherited Assign(Source);
end;

end.
 
