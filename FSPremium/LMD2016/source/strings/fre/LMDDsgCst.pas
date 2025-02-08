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
  SLMDInvalidHandlerName            = '''%s'' n'#39'est pas un nom valide pour un �venement.';
  SLMDInvalidHandlerOwner           = '''%s'' has invalid event handler owner.';
  SLMDItemExist                     = 'L'#39'�l�ment "%s" existe d�j�';
  SLMDNotImplemented                = 'Pas impl�ment�';

  SLMDItemNotFound                  = 'El�ment non trouv�';
  SLMDNamedItemNotFound             = 'El�ment ''%s'' non trouv�';

  SLMDDsgnrCompLockedDel            = 'Le composant ''%s'' ou un de ses enfants ne peut pas' +
                                      #13#10 + '�tre supprim� car il est v�rrouill�.';
  SLMDDsgnrCompsLockedDel           = 'Des composants sont verrouill�s. Impossile de supprimer.';
  SLMDDsgnrMastBeActive             = 'Designer doit �tre actif';
  SLMDDsgnrMastBeInactive           = 'Designer doit �tre inactif';
  SLMDDsgnrMisingDesignCtrl         = 'Design control n'#39'est pas sp�cifi�';
  SLMDDsgnrMisingSelection          = 'Pas de composant s�lectionn�';
  SLMDDsgnrRootHaveParent           = 'Design control parent doit �tre nil';
  SLMDDsgnrMisingDesignPanel        = 'Design panel n'#39'est pas sp�cifi�';
  SLMDDsgnrDesignPanelIsUsed        = 'Design panel ''%s'' est utilis� par un autre designer';
  SLMDDsgnrCanNotSelectComp         = 'Le composant ''%s'' ne peut pas �tre s�lectionn�';
  SLMDDsgnrCompHaveNoVisualRepr     = 'Le composant ''%s'' n'#39'a pas de repr�sentation visuelle';
  SLMDDsgnrSameCollections          = 'S�lection et RootChildren ne peuvent pas  ' +
                                      'se r�f�rer au m�me composant.';

  SLMDPropPageUnableActivateItem    = 'L'#39'�l�ment ne peut pas �tre activ�';

  SLMDPropInspObjectsLocked         = 'L'#39'inspecteur d''objets change la valeur d''une propri�t�. ' +
                                      'Op�ration impossible actuellement.';
  SLMDPropInspOutOfRange            = 'La valeur doit �re entre %d et %d';
  SLMDPropInspInvPropValue          = 'Valeur de propri�t� non valide.';
  SLMDPropInspEditError             = 'Modification non disponible';

  SLMDStrErDlgCaption               = 'Editeur String List';
  SLMDStrErDlgOkBtnCaption          = '&OK';
  SLMDStrErDlgCancelBtnCaption      = 'Anuler';
  SLMDStrErDlgLinesCountTemplate    = '%d lignes';

  SLMDDgrmSelItemError              = 'Impossible de s�lectionner un �l�ment invisible';
  SLMDDgrmSelLinkError              = 'Impossible de s�lectionner un lien invisible';
  SLMDDgrmShowItemError             = 'Impossible d'#39'afficher un �l�ment invisible';

  SLMDObtCmBxNoObjectsSelected      = 'Aucun �l�ment s�lectionn�';
  SLMDObtCmBxManyObjectsSelected    = '%d �l�ment(s) s�lectionn�(s)';
  SLMDObtCmBxSameCollections        = 'S�lection et ListObjects ne doivent pas ' +
                                      'se r�f�rer au m�me composant.';

  SLMDDsgMgrDublicateDesigner       = 'Designer dupliqu�: ''%s''';
  SLMDDsgMgrNonActiveCurDesigner    = 'Le designer courant doit �tre actif';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
