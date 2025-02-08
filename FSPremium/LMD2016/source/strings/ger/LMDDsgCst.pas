unit LMDDsgCst;

{
  ##############################################################################
  # Author:           LMD Innovative (YB)
  # Created:          6.10.2002
  # Description:      Contains resource strings needed in the
  #                   LMD Design Pack
  # State:            DEVELOPING
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # 2.0: Several constants were added
  ##############################################################################
}

interface

resourcestring
  SLMDInvalidItemName = 'Ung�ltiger Name: "%s"';
  SLMDInvalidHandlerName = '''%s'' ist kein g�ltiger Name f�r Ereignis.';
  SLMDInvalidHandlerOwner           = '''%s'' has invalid event handler owner.';
  SLMDItemExist = 'Element "%s" existiert bereits';
  SLMDNotImplemented = 'Nicht implementiert';

  SLMDItemNotFound = 'Objekt nicht gefunden';
  SLMDNamedItemNotFound = 'Objekt "%s" wurde nicht gefunden';

  SLMDDsgnrCompLockedDel = 'Element "%s" oder eines der enthaltenen Objekte kann' +
                           #13#10 + 'nicht gel�scht werden, da diese gesperrt sind';
  SLMDDsgnrCompsLockedDel = 'Einige Objekte sind gesperrt. L�schoperation daher nicht m�glich';
  SLMDDsgnrMastBeActive = 'Designer muss aktviert sein';
  SLMDDsgnrMastBeInactive = 'Designer muss deaktiviert sein';
  SLMDDsgnrMisingDesignCtrl = 'Designer Komponente nicht zugeordnet';
  SLMDDsgnrMisingSelection = 'Selection Komponente nicht festgelegt'; 
  SLMDDsgnrRootHaveParent = 'Parent Eigenschaft der Designer Komponente muss nil sein';
  SLMDDsgnrMisingDesignPanel = 'Design Panel nicht zugeordnet';
  SLMDDsgnrDesignPanelIsUsed = 'Design Panel "%s" wird von einer anderen Designer Komponente verwendet';
  SLMDDsgnrCanNotSelectComp = 'Objekt "%s" kann nicht ausgew�hlt werden';
  SLMDDsgnrCompHaveNoVisualRepr = 'Objekt "%s" ist nicht sichtbar';
  SLMDDsgnrSameCollections = 'Auswahl und RootChildren d�rfen nicht auf ' +
                             'die selbe Komponente verweisen.';

  SLMDPropPageUnableActivateItem = 'Element kann nicht aktiviert werden';
  SLMDPropInspObjectsLocked = 'Property Inspector �ndert Eigenschaftswert. ' +
                             'Operation ist zu diesem Zeitpunkt nicht m�glich';
  SLMDPropInspOutOfRange = 'Der Wert muss zwischen %d und %d liegen';
  SLMDPropInspInvPropValue = 'Ung�ltiger Wert f�r Eigenschaft';
  SLMDPropInspEditError = 'Bearbeitungs-Schritt nicht verf�gbar';

  SLMDStrErDlgCaption = 'String List Editor';
  SLMDStrErDlgOkBtnCaption = '&Ok';
  SLMDStrErDlgCancelBtnCaption = 'Abbrechen';
  SLMDStrErDlgLinesCountTemplate = '%d Zeilen';

  SLMDDgrmSelItemError = 'Unsichtbare Objekte k�nnen nicht ausgew�hlt werden';
  SLMDDgrmSelLinkError = 'Unsichtbare Links k�nnen nicht ausgew�hlt werden';
  SLMDDgrmShowItemError = 'Unsichtbares Element kann nicht angezeigt werden';

  SLMDObtCmBxNoObjectsSelected = 'Kein Objekt ausgew�hlt';
  SLMDObtCmBxManyObjectsSelected = '%d Objekt(e) ausgew�hlt';
  SLMDObtCmBxSameCollections        = 'Auswahhl und ListObjects d�rfen nicht ' +
                                      'auf die selbe Komponente verweisen.'; 

  SLMDDsgMgrDublicateDesigner = 'Doppelter Designer: %s';
  SLMDDsgMgrNonActiveCurDesigner = 'Aktueller Designer muss aktiviert sein';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
