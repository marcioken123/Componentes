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
 IDS_MathFunctions = 'Fonctions mathématiques';
 // ----------------------------------------------------------------------------

 IDS_PATH='Chemin:';
 IDS_ON='ON';
 IDS_OFF='OFF';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Sélectionner...';
 IDS_SELECTOPTIONS='Cochez le(s) bonne(s) option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Ajouter sect&ion';
 IDS_DELSECTION='Supprim&er section';
 IDS_RENSECTION='Re&nommer section';
 IDS_ADDITEM='&Ajouter élément';
 IDS_DELITEM='&Supprimer élément';
 IDS_RENITEM='&Renommer élément';
 IDS_SMALLICONS='&Petites icônes';
 IDS_LARGEICONS='&Grandes icônes';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendrier';
 IDS_ACTUALDATE='Aujourd''hui'; 

 //EditControls
 IDS_INSERT='&Insérer';
 IDS_COPY='&Copier';
 IDS_CUT='&Couper';
 IDS_UNDO='&Défaire';
 IDS_SELECTALL='Sélectionner tout';
 IDS_DELETE='&Supprimer';
 IDS_SEARCH='Chercher';
 IDS_SEARCHMSG1='Début de texte ... relancer à partir de la fin ?';
 IDS_SEARCHMSG2='Fin de texte ... relancer à partir du début ?';
 IDS_REPLACE='Remplacer';
 IDS_WORDWRAP='Retour à la ligne automatique';
 IDS_LINED='Lignes';
 IDS_REDO='&Refaire';
 IDS_FONT='Police';
 IDS_CLEAR='Nettoyer';
 IDS_ALIGNLEFT='Aligner à gauche';
 IDS_ALIGNRIGHT='Aligner à droite';
 IDS_ALIGNCENTER='Centrer';
 IDS_STATISTICS='Statistiques sur le texte';
 IDS_OPEN='Ouvrir';
 IDS_SAVE='Sauvegarder';
 IDS_PRINT='Imprimer';
 IDS_PAGE='Page';
 IDS_EDIT='Editer';

 // Component Messages
 IDS_MUSTSHOWONE='Un style d''horloge doît être actif !';
 IDS_INVALIDOWNER='Propriétaire non valide(owner) (<>TForm) ou seconde instance sur la fiche';
 IDS_INTERVALNOTFIT='Intervalle non compatible avec la propriété MinInterval!';

 // TLMDAssist
 IDS_NEXT='&Suivant >';
 IDS_BACK='< &Précédent';
 IDS_FINISH='&Terminer';
 IDS_HELP='&Aide';
 IDS_CLOSE='&Quitter';
 IDS_CANCEL='Annuler';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'Cette propriété n''est plus utilisée dans LMD-Tools!';

 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = 'MessageHintControl property is not assigned!';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='a déjà été démarré...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Mémoire disponible:';
 IDS_AboutSysRes='Ressources Système:';
 IDS_AboutCompatible='ou compatible';
 IDS_AboutPlatform='Plate-forme, CPU:';
 IDS_FREE='libre';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Custom color...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Sélectionner un dossier...';
 IDS_DIRDRIVE='&Lecteur:';
 IDS_DIRPATH='&Chemin:';
 IDS_NEWPATH='&Nouveau dossier';

 {TLMDTipDlg}
 IDS_TIPERROR='Pas de conseil disponible - La fenêtre ne sera pas affichée...';
 IDS_SHOWATSTART='Montrer le(s) conseil(s) à chaque démarrage';
 IDS_TIPNEXT='Conseil &suivant';
 IDS_TIPPREV='Conseil &précédent';

 {TLMDWindowList}
 IDS_WLCAPTION='Liste des fenêtres';
 IDS_WLDESC='&Fenêtre(s) disponible(s):';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Ne plus montrer';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Saisie';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Editeur de texte';

implementation

end.
