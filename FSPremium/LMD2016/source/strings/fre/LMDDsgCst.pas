unit LMDDsgCst;
{
  ##############################################################################
  # Author:           LMD Innovative (YB)
  # 		      Translation by David Le Franc
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
  SLMDInvalidItemName               = '''%s'' n'#39'est pas un nom valide.';
  SLMDInvalidHandlerName            = '''%s'' n'#39'est pas un nom valide pour un évenement.';
  SLMDInvalidHandlerOwner           = '''%s'' has invalid event handler owner.';
  SLMDItemExist                     = 'L'#39'élément "%s" existe déjà';
  SLMDNotImplemented                = 'Pas implémenté';

  SLMDItemNotFound                  = 'Elément non trouvé';
  SLMDNamedItemNotFound             = 'Elément ''%s'' non trouvé';

  SLMDDsgnrCompLockedDel            = 'Le composant ''%s'' ou un de ses enfants ne peut pas' +
                                      #13#10 + 'être supprimé car il est vérrouillé.';
  SLMDDsgnrCompsLockedDel           = 'Des composants sont verrouillés. Impossile de supprimer.';
  SLMDDsgnrMastBeActive             = 'Designer doit être actif';
  SLMDDsgnrMastBeInactive           = 'Designer doit être inactif';
  SLMDDsgnrMisingDesignCtrl         = 'Design control n'#39'est pas spécifié';
  SLMDDsgnrMisingSelection          = 'Pas de composant sélectionné';
  SLMDDsgnrRootHaveParent           = 'Design control parent doit être nil';
  SLMDDsgnrMisingDesignPanel        = 'Design panel n'#39'est pas spécifié';
  SLMDDsgnrDesignPanelIsUsed        = 'Design panel ''%s'' est utilisé par un autre designer';
  SLMDDsgnrCanNotSelectComp         = 'Le composant ''%s'' ne peut pas être sélectionné';
  SLMDDsgnrCompHaveNoVisualRepr     = 'Le composant ''%s'' n'#39'a pas de représentation visuelle';
  SLMDDsgnrSameCollections          = 'Sélection et RootChildren ne peuvent pas  ' +
                                      'se référer au même composant.';

  SLMDPropPageUnableActivateItem    = 'L'#39'élément ne peut pas être activé';

  SLMDPropInspObjectsLocked         = 'L'#39'inspecteur d''objets change la valeur d''une propriété. ' +
                                      'Opération impossible actuellement.';
  SLMDPropInspOutOfRange            = 'La valeur doit êre entre %d et %d';
  SLMDPropInspInvPropValue          = 'Valeur de propriété non valide.';
  SLMDPropInspEditError             = 'Modification non disponible';

  SLMDStrErDlgCaption               = 'Editeur String List';
  SLMDStrErDlgOkBtnCaption          = '&OK';
  SLMDStrErDlgCancelBtnCaption      = 'Anuler';
  SLMDStrErDlgLinesCountTemplate    = '%d lignes';

  SLMDDgrmSelItemError              = 'Impossible de sélectionner un élément invisible';
  SLMDDgrmSelLinkError              = 'Impossible de sélectionner un lien invisible';
  SLMDDgrmShowItemError             = 'Impossible d'#39'afficher un élément invisible';

  SLMDObtCmBxNoObjectsSelected      = 'Aucun élément sélectionné';
  SLMDObtCmBxManyObjectsSelected    = '%d élément(s) sélectionné(s)';
  SLMDObtCmBxSameCollections        = 'Sélection et ListObjects ne doivent pas ' +
                                      'se référer au même composant.';

  SLMDDsgMgrDublicateDesigner       = 'Designer dupliqué: ''%s''';
  SLMDDsgMgrNonActiveCurDesigner    = 'Le designer courant doit être actif';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
