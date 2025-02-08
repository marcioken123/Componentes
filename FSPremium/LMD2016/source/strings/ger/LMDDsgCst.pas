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
  SLMDInvalidItemName = 'Ungültiger Name: "%s"';
  SLMDInvalidHandlerName = '''%s'' ist kein gültiger Name für Ereignis.';
  SLMDInvalidHandlerOwner           = '''%s'' has invalid event handler owner.';
  SLMDItemExist = 'Element "%s" existiert bereits';
  SLMDNotImplemented = 'Nicht implementiert';

  SLMDItemNotFound = 'Objekt nicht gefunden';
  SLMDNamedItemNotFound = 'Objekt "%s" wurde nicht gefunden';

  SLMDDsgnrCompLockedDel = 'Element "%s" oder eines der enthaltenen Objekte kann' +
                           #13#10 + 'nicht gelöscht werden, da diese gesperrt sind';
  SLMDDsgnrCompsLockedDel = 'Einige Objekte sind gesperrt. Löschoperation daher nicht möglich';
  SLMDDsgnrMastBeActive = 'Designer muss aktviert sein';
  SLMDDsgnrMastBeInactive = 'Designer muss deaktiviert sein';
  SLMDDsgnrMisingDesignCtrl = 'Designer Komponente nicht zugeordnet';
  SLMDDsgnrMisingSelection = 'Selection Komponente nicht festgelegt'; 
  SLMDDsgnrRootHaveParent = 'Parent Eigenschaft der Designer Komponente muss nil sein';
  SLMDDsgnrMisingDesignPanel = 'Design Panel nicht zugeordnet';
  SLMDDsgnrDesignPanelIsUsed = 'Design Panel "%s" wird von einer anderen Designer Komponente verwendet';
  SLMDDsgnrCanNotSelectComp = 'Objekt "%s" kann nicht ausgewählt werden';
  SLMDDsgnrCompHaveNoVisualRepr = 'Objekt "%s" ist nicht sichtbar';
  SLMDDsgnrSameCollections = 'Auswahl und RootChildren dürfen nicht auf ' +
                             'die selbe Komponente verweisen.';

  SLMDPropPageUnableActivateItem = 'Element kann nicht aktiviert werden';
  SLMDPropInspObjectsLocked = 'Property Inspector ändert Eigenschaftswert. ' +
                             'Operation ist zu diesem Zeitpunkt nicht möglich';
  SLMDPropInspOutOfRange = 'Der Wert muss zwischen %d und %d liegen';
  SLMDPropInspInvPropValue = 'Ungültiger Wert für Eigenschaft';
  SLMDPropInspEditError = 'Bearbeitungs-Schritt nicht verfügbar';

  SLMDStrErDlgCaption = 'String List Editor';
  SLMDStrErDlgOkBtnCaption = '&Ok';
  SLMDStrErDlgCancelBtnCaption = 'Abbrechen';
  SLMDStrErDlgLinesCountTemplate = '%d Zeilen';

  SLMDDgrmSelItemError = 'Unsichtbare Objekte können nicht ausgewählt werden';
  SLMDDgrmSelLinkError = 'Unsichtbare Links können nicht ausgewählt werden';
  SLMDDgrmShowItemError = 'Unsichtbares Element kann nicht angezeigt werden';

  SLMDObtCmBxNoObjectsSelected = 'Kein Objekt ausgewählt';
  SLMDObtCmBxManyObjectsSelected = '%d Objekt(e) ausgewählt';
  SLMDObtCmBxSameCollections        = 'Auswahhl und ListObjects dürfen nicht ' +
                                      'auf die selbe Komponente verweisen.'; 

  SLMDDsgMgrDublicateDesigner = 'Doppelter Designer: %s';
  SLMDDsgMgrNonActiveCurDesigner = 'Aktueller Designer muss aktiviert sein';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
