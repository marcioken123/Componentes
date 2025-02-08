unit LMDShapeButtonColor;
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

LMDShapeButtonColor unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Classes, LMDObject;

type
  {----------------------TLMDShapeButtonColor----------------------------------}
  TLMDShapeButtonColor=class(TLMDObject)
  private
    FDisabled,
    FDown,
    FMouseOver,
    FOptionSet,
    FUp:TColor;
    procedure SetColor(index: Integer; aValue: TColor);
  public
    constructor Create(Owner:TPersistent=nil);override;
  published
    property Disabled: TColor index 0 read FDisabled write SetColor default clBtnFace;
    property Down: TColor index 1 read FDown write SetColor default clBtnFace;
    property MouseOver: TColor index 2 read FMouseOver write SetColor default clBtnFace;
    property OptionSet: TColor index 3 read FOptionSet write SetColor default clBtnFace;
    property Up: TColor index 4 read FUp write SetColor default clBtnFace;
  end;

implementation

{************************ Object TLMDShapeButtonColor **************************}
{------------------------- Private --------------------------------------------}
procedure TLMDShapeButtonColor.SetColor(index: Integer; aValue: TColor);
begin
  case Index of
    0: if aValue<>FDisabled then FDisabled:=aValue else exit;
    1: if aValue<>FDown then FDown:=aValue else exit;
    2: if aValue<>FMouseOver then FMouseOver:=aValue else exit;
    3: if aValue<>FOptionSet then FOptionSet:=aValue else exit;
    4: if aValue<>FUp then FUp:=aValue else Exit;
  end;
  Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDShapeButtonColor.Create;
begin
  inherited Create;
  FDisabled:=clBtnFace;
  FDown:=clBtnFace;
  FMouseOver:=clBtnFace;
  FOptionSet:=clBtnFace;
  Fup:=clBtnFace;
end;

end.
 
