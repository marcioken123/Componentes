unit LMD3DEffectButton;
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

LMD3DEffectButton unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustom3DButton;

type
  TLMD3DEffectButton=class(TLMDCustom3DButton)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ButtonFace;
    property ButtonLayout;
    property DropDownMenu;
    property EnterColor;
    property EnterColorChange;
    property Glyph;
    property NumGlyphs;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property Transparent;
    property GroupIndex;
    property AllowAllUp;
    property Compressed;
    property PixelFormat;
    property QuickDraw default false;
  end;

implementation

{------------------------- Protected ------------------------------------------}
constructor TLMD3DEffectButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQuickDraw:=False;
  FKind:=0;
end;

end.
 
