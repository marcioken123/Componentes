unit LMDListComboBox;
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

LMDListComboBox unit (JH)
-------------------------

Combobox with a drop down list, combo box is a base edit descendant (effects)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  Windows,
  Graphics,
  LMDCustomListComboBox;

type
  TLMDListComboBox = class (TLMDCustomListComboBox)
  published
    property Items;
    property ItemIndex;
    property Style;
    property DropDownWidth;
    property DropDownCount;
  end;

  TLMDLabeledListComboBox = class(TLMDListComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ItemIndex;  
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledListComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
