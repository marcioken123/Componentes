unit LMDExtListBox;
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

LMDExtListBox unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomListBox;

type
  TLMDExtListBox = class (TLMDCustomListBox)
  public
    property Count;
    property CtlXP;  // Compatibility
  published
    property AutoComplete;
    property VirtualMode;
    property Columns;
    property Items;
    property ItemAutoHeight;
    property EditOptions;
    property LargeTextOptions;
    property VerticalScrollBar;
    property Margin;
    property MultiLine;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property HorzGridColor;
    property HorzGridStyle;
    property HorzGridLine;

    // Event for internal edit control
    property OnEditShow;
    property OnEditMeasure;
    property OnEditChange;
    property OnEditHide;

    property OnData;
    property OnDataObject;
    property OnDataFind;
  end;

  TLMDLabeledExtListBox = class(TLMDExtListBox)
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
constructor TLMDLabeledExtListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;
end.
 
