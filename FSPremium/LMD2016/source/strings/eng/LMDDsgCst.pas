unit LMDDsgCst;

{
  ##############################################################################
  # Author:           LMD Innovative (YB)
  # Created:          6.10.2002
  # Description:      Contains resource strings needed in the
  #                   LMD Design Pack
  # State:            
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # 2.0: Several constants were added
  ##############################################################################
}

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

  SLMDPropPageUnableActivateItem    = 'Item can not be activated';

  SLMDPropInspObjectsLocked         = 'Property inspector is changing property value. ' +
                                      'Operation not possible at this time.';
  SLMDPropInspOutOfRange            = 'Value must be between %d and %d';
  SLMDPropInspInvPropValue          = 'Invalid property value';
  SLMDPropInspEditError             = 'Edit operation is unavailable';

  SLMDStrErDlgCaption               = 'String List Editor';
  SLMDStrErDlgOkBtnCaption          = '&Ok';
  SLMDStrErDlgCancelBtnCaption      = 'Cancel';
  SLMDStrErDlgLinesCountTemplate    = '%d lines';

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
