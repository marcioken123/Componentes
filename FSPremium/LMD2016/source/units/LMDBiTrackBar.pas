unit LMDBiTrackBar;
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

LMDBiTrackBar unit (AH)
-----------------------
TrackBar control with two thumbs and option to draw diapason bar

Changes
-------
Release 10.0 (August 2009)
 - Initial Release

###############################################################################}


interface

uses
  LMDCustomBiTrackBar;

type
  TLMDBiTrackBar = class(TLMDCustomBiTrackBar)
  published
    property DiapasonFillObject;
    property RightPosition;
    property LeftPosition;
  end;

implementation

end.
