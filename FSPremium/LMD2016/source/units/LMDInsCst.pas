unit LMDInsCst;

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

LMDInsCst unit (YB)
-------------------
Contains resource strings needed in LMD InspectorPack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  SLMDItemNotFound                  = 'Item not found.';

  SLMDPropPageUnableActivateItem    = 'Item can not be activated.';

  SLMDPropInspObjectsLocked         = 'Property inspector is changing property value. ' +
                                      'Operation not possible at this time.';
  SLMDPropInspOutOfRange            = 'Value must be between %d and %d';
  SLMDPropInspInvPropValue          = 'Invalid property value.';
  SLMDPropInspEditError             = 'Edit operation is unavailable.';
  SLMDPropInspNonSameComp           = 'The name %s denotes more then one component ' +
                                      'in different contexts.';

  SLMDStrErDlgCaption               = 'String List Editor';
  SLMDStrErDlgOkBtnCaption          = '&Ok';
  SLMDStrErDlgCancelBtnCaption      = 'Cancel';
  SLMDStrErDlgLinesCountTemplate    = '%d lines';

implementation

end.
