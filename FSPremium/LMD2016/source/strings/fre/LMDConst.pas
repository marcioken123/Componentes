unit LMDConst;
{###############################################################################

LMDConst unit (--)
------------------
Unit containing resource strings used by the components
already available in several other languages!

French version by David Le Franc.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

resourcestring
  // 8.0  --> TLMDCustomSimpleLabel
 IDS_OPENURL='&Ouvrir URL';
 IDS_COPYURL='&Copier URL';
 // ------

 // 7.1 MathParser
 IDS_SyntaxError = 'Erreur de syntaxe';
 IDS_CloseBracketExpected = '")" attendue';
 IDS_ExpressionEmpty = 'L''expression est vide';
 IDS_OpenBracketExpected = '"(" attendue';
 IDS_InvalidArgument = 'Argument non valide';
 IDS_MathFunctions = 'Fonctions math�matiques';
 // ----------------------------------------------------------------------------

 IDS_PATH='Chemin:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 // TLMDCheckListBoxDlg
 IDS_SELECT='S�lectionner...';
 IDS_SELECTOPTIONS='Cochez le(s) bonne(s) option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Ajouter sect&ion';
 IDS_DELSECTION='Supprim&er section';
 IDS_RENSECTION='Re&nommer section';
 IDS_ADDITEM='&Ajouter �l�ment';
 IDS_DELITEM='&Supprimer �l�ment';
 IDS_RENITEM='&Renommer �l�ment';
 IDS_SMALLICONS='&Petites ic�nes';
 IDS_LARGEICONS='&Grandes ic�nes';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendrier';
 IDS_ACTUALDATE='Aujourd''hui'; 

 //EditControls
 IDS_INSERT='&Ins�rer';
 IDS_COPY='&Copier';
 IDS_CUT='&Couper';
 IDS_UNDO='&D�faire';
 IDS_SELECTALL='S�lectionner tout';
 IDS_DELETE='&Supprimer';
 IDS_SEARCH='Chercher';
 IDS_SEARCHMSG1='D�but de texte ... relancer � partir de la fin ?';
 IDS_SEARCHMSG2='Fin de texte ... relancer � partir du d�but ?';
 IDS_REPLACE='Remplacer';
 IDS_WORDWRAP='Retour � la ligne automatique';
 IDS_LINED='Lignes';
 IDS_REDO='&Refaire';
 IDS_FONT='Police';
 IDS_CLEAR='Nettoyer';
 IDS_ALIGNLEFT='Aligner � gauche';
 IDS_ALIGNRIGHT='Aligner � droite';
 IDS_ALIGNCENTER='Centrer';
 IDS_STATISTICS='Statistiques sur le texte';
 IDS_OPEN='Ouvrir';
 IDS_SAVE='Sauvegarder';
 IDS_PRINT='Imprimer';
 IDS_PAGE='Page';
 IDS_EDIT='Editer';

 // Component Messages
 IDS_MUSTSHOWONE='Un style d''horloge do�t �tre actif !';
 IDS_INVALIDOWNER='Propri�taire non valide(owner) (<>TForm) ou seconde instance sur la fiche';
 IDS_INTERVALNOTFIT='Intervalle non compatible avec la propri�t� MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Suivant >';
 IDS_BACK='< &Pr�c�dent';
 IDS_FINISH='&Terminer';
 IDS_HELP='&Aide';
 IDS_CLOSE='&Quitter';
 IDS_CANCEL='Annuler';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Cette propri�t� n''est plus utilis�e dans LMD-Tools!';

 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = 'MessageHintControl property is not assigned!';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='a d�j� �t� d�marr�...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='M�moire disponible:';
 IDS_AboutSysRes='Ressources Syst�me:';
 IDS_AboutCompatible='ou compatible';
 IDS_AboutPlatform='Plate-forme, CPU:';
 IDS_FREE='libre';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Custom color...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='S�lectionner un dossier...';
 IDS_DIRDRIVE='&Lecteur:';
 IDS_DIRPATH='&Chemin:';
 IDS_NEWPATH='&Nouveau dossier';

 {TLMDTipDlg}
 IDS_TIPERROR='Pas de conseil disponible - La fen�tre ne sera pas affich�e...';
 IDS_SHOWATSTART='Montrer le(s) conseil(s) � chaque d�marrage';
 IDS_TIPNEXT='Conseil &suivant';
 IDS_TIPPREV='Conseil &pr�c�dent';

 {TLMDWindowList}
 IDS_WLCAPTION='Liste des fen�tres';
 IDS_WLDESC='&Fen�tre(s) disponible(s):';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Ne plus montrer';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Saisie';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editeur de texte';

implementation

end.
