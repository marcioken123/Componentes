unit LMDTransparent;
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

LMDTransparent unit ()
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
  lmdgraph,
  LMDObject;

type
  TLMDTransparent = class(TLMDObject)
  private
    FColor:TColor;
    FStyle:TLMDTransparentMode;
    procedure SetColor(AValue:TColor);
    procedure SetStyle(AValue:TLMDTransparentMode);
    function GetTransparent:Boolean;
  public
    constructor Create(Owner:TPersistent=nil);override;
    procedure Assign(Source:TPersistent);override;
    property Transparent:Boolean read GetTransparent;
  published
    Property Color:TColor read FColor write SetColor default clBtnFace;
    Property Mode:TLMDTransparentMode read FStyle write SetStyle default tpNone;
  end;

implementation

{------------------------- Private --------------------------------------------}
Procedure TLMDTransparent.SetColor(aValue:TColor);
begin
  if aValue<>FColor then
    begin
      FColor:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDTransparent.SetStyle(aValue:TLMDTransparentMode);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDTransparent.GetTransparent;
begin
 case Mode of
   tpNone, tpTransparentColor:
     result:=False;
   tpRestoreBack, tpRBTranspColor:
     result:=True;
 else
   result:=false;
 end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDTransparent.Create;
begin
  inherited Create;
  FColor:=clBtnFace;
  FStyle:=tpNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparent.Assign(source:TPersistent);
begin
  if source=self then exit;
  if Source is TLMDTransparent then
    begin
      FColor:=TLMDTransparent(Source).Color;
      FStyle:=TLMDTransparent(source).Mode;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

end.
