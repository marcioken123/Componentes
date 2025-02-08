unit LMDImageListBox;
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

LMDImageListBox unit (RM)
-------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomImageListBox;

type
  TLMDImageListBox = class (TLMDCustomImageListBox)
  public
    property Count;
  published
    property GlyphNumber;
    property GlyphColumn;
    property ItemIndex;
    property ImageList;
    property ListIndex;
    property Items;
    property Layout;
    property ImagesOnly;
    property MultiLine;

    // 6.1 additions
    property Margin;
    property Columns;
    property LargeTextOptions;
    property VerticalScrollBar;
    property HorzGridColor;
    property HorzGridStyle;
    property HorzGridLine;

    property EditOptions;
    // Event for internal edit control
    property OnEditShow;
    property OnEditMeasure;
    property OnEditChange;
    property OnEditHide;

    property AutoComplete;
    property VirtualMode;

    property OnData;
    property OnDataObject;
    property OnDataFind;
  end;

 TLMDLabeledImageListBox = class(TLMDImageListBox)
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
constructor TLMDLabeledImageListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;
end.
