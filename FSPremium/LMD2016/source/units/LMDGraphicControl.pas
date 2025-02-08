unit LMDGraphicControl;
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

LMDGraphicControl unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDGraph, LMDBase, LMDBevel, LMDBaseGraphicControl;

type
  {-------------------TLMDGraphicControl --------------------------------------}
  TLMDGraphicControl=class(TLMDBaseGraphicControl)
  private
    FBevel:TLMDBevel;
    procedure SetBevel(aValue:TLMDBevel);
  protected
    function BevelExt:Integer;
    function DblBevelExt:Integer;
    function BeveledRect:TRect;
    procedure Paint;Override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Bevel:TLMDBevel read FBevel write SetBevel;
  end;

implementation
uses
  SysUtils, LMDClass;
{************************ Class TLMDGraphicControl ****************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDGraphicControl.SetBevel(aValue:TLMDBevel);
begin
  FBevel.Assign(aValue);
  Perform (CM_LMDBEVELCHANGED, 0, 0);
end;

{------------------------- Protected ------------------------------------------}
function TLMDGraphicControl.BevelExt:Integer;
begin
  result:=FBevel.BevelExtend
end;

{------------------------------------------------------------------------------}
function TLMDGraphicControl.DblBevelExt:Integer;
begin
  result:=2*BevelExt;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicControl.BeveledRect:TRect;
begin
  result:=FBevel.ClientRect(GetClientRect);
end;

{------------------------- Public----------------------------------------------}
constructor TLMDGraphicControl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBevel:=TLMDBevel.Create;
  FBevel.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDGraphicControl.Destroy;
begin
  FBevel.OnChange:=nil;
  FreeAndNil(FBevel);;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDGraphicControl.Paint;
begin

  if csLoading in ComponentState then exit;

  if GetEmpty and (FBevel.BevelExtend=0) then
    begin
      inherited Paint;
      exit;
    end;

  {draw the Bevel}
  FBevel.PaintBevel(Canvas, GetClientRect, Transparent);
end;

end.
 
