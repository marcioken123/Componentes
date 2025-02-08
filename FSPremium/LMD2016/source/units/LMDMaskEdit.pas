unit LMDMaskEdit;
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

LMDMaskEdit unit (JH)
---------------------

masked text input control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomMaskEdit;

type
  TLMDMaskEdit = class (TLMDCustomMaskEdit)
  published
    property About;
    property Alignment;
    property AutoSelect;
    property Bevel;
    property BlankChar;
    property Caret;
    property CharCase;
    property CurrencySettings;
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property DateSettings;
    property Decimals;
    property Flat;
    property FocusOnMouseAbove;
    property Font;
    property Font3D;
    property ForceMaskCheck;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property Mask;
    property MaskType;
    property MaxLength;
    property NumberBase;
    property OEMConvert;
    property Options;
    property ProcessBlankChar;
    property SuppressBlankCharOnDelete;
    property ReadOnly;
    property Suffix;
    property TabOnEnter;
    property Text;
    property TimeSettings;
    property Transparent;

    property OnBtnClick;
    property OnUserRule;
  end;

  TLMDLabeledMaskEdit = class(TLMDMaskEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;
end.
 
