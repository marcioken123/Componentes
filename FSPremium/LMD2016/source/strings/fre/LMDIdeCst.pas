unit LMDIdeCst;

{###############################################################################

LMDIdeCst unit (YB)
-------------------
Contains resource strings needed in LMD IDE-Tools pack.

Changes
-------

###############################################################################}

interface

resourcestring
  { Component palette }
  
  SLMDCompClassAlradyRegistered = 'La classe du composant %s est d�j� enregistr�e.';
  SLMDStdPage                   = 'Standard'; //!!!

  { Sprigs }

  SLMDUnnamedComponent = '<Composants[%d]>';

  { Project manager }

  SLMDProjNodeClassHasNoIdent    = 'L'#39'identifiant pour la classe %s est ind�fini.';
  SLMDProjNodeClassNotRegistered = 'Node class avec ''%s'' ident n'#39'est pas enregistr�.';
  SLMDProjNodeDefaultDisplayName = '<sans nom>';

  SLMDNoOpenedDocFound           = 'No TLMDOpenedDocument found on the ' +
                                   'specified editor frame.';

  { Align palette }

  SLMDAlignPaletteCaption = 'Alignement';

  SLMDAlignLeftHint = 'Aligner � gauche';
  SLMDAlignHCenterHint = 'Aligner les centres horizontalement';
  SLMDAlignHCenterInWindowHint = 'Centrer horizontalement dans la fen�tre';
  SLMDAlignHSpaceEqHint = 'Espace r�guli�rement, horizontalement';
  SLMDAlignRightHint = 'Aligner � droite';
  SLMDAlignTopHint = 'Aligner en haut';
  SLMDAlignVCenterHint = 'Aligner les centres verticalement';
  SLMDAlignVCenterInWindowHint = 'Centrer verticalement dans la fen�tre';
  SLMDAlignVSpaceEqHint = 'Espacer r�guli�rement, verticalement';
  SLMDAlignBottomHint = 'Aligner en bas';

  { Tab order dialog }

  SLMDTabOrderDlgCaption     = 'Ordre de tabulation';
  SLMDTabOrderDlgListCaption = 'Controles par ordre de tabulation:';
  SLMDTabOrderDlgNone        = '(vide)';
  SLMDTabOrderDlgOk          = 'OK';
  SLMDTabOrderDlgCancel      = 'Annuler';

  { Creation order dialog }

  SLMDCreationOrderDlgCaption     = 'Ordre de cr�ation';
  SLMDCreationOrderDlgListCaption = 'Ordre de cr�ation des composants non visuels:';
  SLMDCreationOrderDlgNone        = '(vide)';
  SLMDCreationOrderDlgOk          = 'OK';
  SLMDCreationOrderDlgCancel      = 'Annuler';
  { Actions }

  SLMDActnAlignToGrid = 'Align to grid';
  SLMDActnAlignLeft = 'Align left edges';
  SLMDActnAlignRight = 'Align right edges';
  SLMDActnAlignHSpaceEqually = 'Space equally, horizontally';
  SLMDActnAlignHCenter = 'Align horizontal centers';
  SLMDActnAlignHCenterInWindow = 'Center horizontally in window';
  SLMDActnAlignTop = 'Align tops';
  SLMDActnAlignBottom = 'Align bottoms';
  SLMDActnAlignVSpaceEqually = 'Space equally, vertically';
  SLMDActnAlignVCenter = 'Align vertical centers';
  SLMDActnAlignVCenterInWindow = 'Center vertically in window';
  SLMDActnDsgCut = 'Cut';
  SLMDActnDsgCopy = 'Copy';
  SLMDActnDsgPaste = 'Paste';
  SLMDActnDsgSelectAll = 'Select all';
  SLMDActnDsgDelSelected = 'Delete selected';
  SLMDActnDsgClearLocks = 'Clear locks';
  SLMDActnDsgLockSelected = 'Lock selection';
  SLMDActnDsgBringToFront = 'Bring to front';
  SLMDActnDsgSendToBack = 'Send to back';
  SLMDActnDsgTabOrderDlg = 'Tab order...';
  SLMDActnDsgCreationOrderDlg = 'Creation order...';

  { Debug controls }

  SLMDProcessNotAccessible = 'Process is not accessible';

implementation

end.
