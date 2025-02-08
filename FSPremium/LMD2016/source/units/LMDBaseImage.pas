unit LMDBaseImage;
{$I lmdcmps.INC}

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

LMDBaseImage unit ()
--------------------

Base image handling component.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDGraph,
  LMDGraphicControl;

type
  {---------------------------- TLMDBaseImage ---------------------------------}
  TLMDBaseImage=class(TLMDGraphicControl)
  private
    FQuickDraw:Boolean;
    FStyle:TLMDBitmapStyle;
    procedure SetQuickDraw(aValue:Boolean);
    procedure SetStyle(aValue:TLMDBitmapStyle);
  protected
    function CorrectBounds:Boolean;virtual;
    procedure AddStyleFlags(var Flags:Word);
    property Style:TLMDBitmapStyle read FStyle write SetStyle default sbNone;
    property QuickDraw:Boolean read FQuickDraw write SetQuickDraw default True;
  public
    constructor Create(AOwner:TComponent);override;
  published
    property About;
  end;

implementation

uses
  Controls, //csReplic
  LMDGraphUtils; //DSF_...

{************************ Class TLMDBaseImage *********************************}
{-------------------------- Private -------------------------------------------}
Procedure TLMDBaseImage.SetQuickDraw(aValue:Boolean);
begin
  if aValue<>FQuickDraw then
    begin
      FQuickDraw:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDBaseImage.SetStyle(aValue:TLMDBitmapStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      InvalidateControl;
    end;
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDBaseImage.AddStyleFlags(var flags:Word);
begin
  case FStyle of
    sbNone, sbAutoSize:flags:=flags or DSF_CLIPRECT;
    sbCenter:flags:=flags or DSF_CLIPRECT or DSF_CENTER;
    sbStretch:flags:=flags or DSF_STRETCH;
    sbTile:flags:=flags or DSF_TILE or DSF_CLIPRECT;
    sbKeepAspRatio:flags:=flags or DSF_STRETCHKEEPRATIO;
    sbKeepHeight:flags:=flags or DSF_STRETCHKEEPHEIGHT or DSF_CLIPRECT;
    sbKeepWidth:flags:=flags or DSF_STRETCHKEEPWIDTH or DSF_CLIPRECT;
  end;
  if BevelExt=0 then flags:=flags XOR DSF_CLIPRECT;
end;

{------------------------------------------------------------------------------}
function TLMDBaseImage.CorrectBounds:Boolean;
begin
  result:=false;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBaseImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FQuickDraw:=True;
  FStyle:=sbNone;
  ControlStyle := ControlStyle + [csReplicatable];
end;

end.
