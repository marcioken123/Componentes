unit LMDDsgCst;

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

LMDDsgCst unit (YB)
-------------------
Contains resource strings needed in LMD DesignPack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  SLMDInvalidItemName               = '''%s'' is not a valid item name.';
  SLMDInvalidHandlerName            = '''%s'' is not a valid event handler name.';
  SLMDInvalidHandlerOwner           = '''%s'' has invalid event handler owner.';
  SLMDItemExist                     = 'Item "%s" is already exist';
  SLMDNotImplemented                = 'Not implemented';

  SLMDItemNotFound                  = 'Item not found';
  SLMDNamedItemNotFound             = 'Item ''%s'' not found';

  SLMDDsgnrCompLockedDel            = 'Component ''%s'' or one of its childrens can not' +
                                      #13#10 + 'be deleted because they are locked';
  SLMDDsgnrCompsLockedDel           = 'Some components are locked. Can not delete components';
  SLMDDsgnrMastBeActive             = 'Designer must be active';
  SLMDDsgnrMastBeInactive           = 'Designer must be inactive';
  SLMDDsgnrMisingDesignCtrl         = 'Design control not specified';
  SLMDDsgnrMisingSelection          = 'Selection component not specified';
  SLMDDsgnrRootHaveParent           = 'Design control parent must be nil';
  SLMDDsgnrMisingDesignPanel        = 'Design panel not specified';
  SLMDDsgnrDesignPanelIsUsed        = 'Design panel ''%s'' is used by another designer';
  SLMDDsgnrCanNotSelectComp         = 'Component ''%s'' can not be selected';
  SLMDDsgnrCompHaveNoVisualRepr     = 'Component ''%s'' has no visual representation';
  SLMDDsgnrSameCollections          = 'Selection and RootChildren must not ' +
                                      'refer to the same component.';

  SLMDDgrmSelItemError              = 'Can not select invisible item';
  SLMDDgrmSelLinkError              = 'Can not select invisible link';
  SLMDDgrmShowItemError             = 'Can not show invisible item';

  SLMDObtCmBxNoObjectsSelected      = 'No items selected';
  SLMDObtCmBxManyObjectsSelected    = '%d item(s) selected';
  SLMDObtCmBxSameCollections        = 'Selection and ListObjects must not ' +
                                      'refer to the same component.';

  SLMDDsgMgrDublicateDesigner       = 'Duplicate designer: ''%s''';
  SLMDDsgMgrNonActiveCurDesigner    = 'Current designer must be active';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
