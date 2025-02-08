unit LMDEdit;
{$I lmdcmps.Inc}

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

LMDEdit unit (JH)
-----------------

Single line text input control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDBaseEdit, LMDCustomEdit;

type
  TLMDEdit = class(TLMDCustomEdit)
  private
  protected
  public
  published
    property About;
    property AutoComplete;
    property AutoSelect;
    property AutoSize;
    property Bevel;
    property Caret;
    property CharCase;
    property Alignment;
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property Flat;
    property FocusOnMouseAbove;
    property Font;
    property Font3D;
    property HideSelection;
    property HighlightBack;
    property HighlightText;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property MaxLength;
    property OEMConvert;
    property Options;
    property PasswordChar;
    property ReadOnly;
    property TabOnEnter;
    property Text;
    property Transparent;
    property OnBtnClick;        
  end;

  TLMDLabeledEdit = class(TLMDEdit)
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
constructor TLMDLabeledEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;

end;

end.
