unit LMDLabelFill;
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

LMDLabelFill unit (??)
----------------------

label with filled letters

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDCustomLabelFill;

type
  TLMDLabelFill = class(TLMDCustomLabelFill)
  published
    property About;
    property Align;
    property Alignment;
    property AutoSize;
    property Bevel;
    property BrushBackColor;
    property Caption;
    property FillObject;
    property FocusControl;
    property Font;
    property FontFX;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property MultiLine;
    property Options;
    property ShowAccelChar;
    property Transparent;
  end;

implementation

end.
 
