unit LMDElConst;
{###############################################################################

LMDElConst unit
---------------
Translation by David Le Franc

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Graphics;

{$R 'LMDElPack.res'}

resourcestring
  SLMDDay  = 'Jour ';
  SLMDWeek = 'Semaine ';
  SLMDHintNextYear = 'Année suivante';
  SLMDHintPrevYear = 'Année précédente';
  SLMDHintNextMonth = 'Mois suivant';
  SLMDHintPrevMonth = 'Mois précédent';
  SLMDCapClear      = 'Effacer';
  SLMDCapToday      = 'Aujourd'#39'hui';
  SLMDCapCalendar   = 'Calendrier';
  SLMDCapOk      = 'OK';
  SLMDCapCancel      = 'Cancel';
  SLMDCapCalendarGB = 'Date';
  SLMDCapClockGB = 'Heure';

  SLMDCustom = 'Personnaliser...';

  SLMDUndo = '&Annuler';
  SLMDCut = 'Co&uper';
  SLMDCopy = '&Copier';
  SLMDPaste = 'C&oller';
  SLMDDelete = '&Supprimer';
  SLMDSelectAll = 'Sélectionner &tout';

  SLMDShiftP = 'Maj+';
  SLMDAltP = 'Alt+';
  SLMDCtrlP = 'Ctrl+';
  SLMDLeftP = 'Gauche+';
  SLMDRightP = 'Droit+';
  SLMDMiddleP = 'Milieu+';
  SLMDDoubleP = 'Double+';
  SLMDLWinP = 'Win+';
  SLMDRWinP = 'Win+';

  SLMDElCantSetThisEntryAs = 'Impossible de définir cette valeur avec %s';
  SLMDElCantGetThisPropAs = 'Impossible d'#39'obtenir cette propriété avec %s';
  SLMDElCantSetThisPropAs = 'Impossible de définir cette propriété avec %s';

  SLMDListIndexOutOfBounds = 'Index de liste [%d] hors limites...';

  SLMDBitmapInvalid = 'L'#39'image Bitmap n'#39'est pas valide';
  SLMDSyntaxError = 'Erreur de syntaxe';
  SLMDCloseBracketExpected = '")" attendu';
  SLMDExpressionEmpty = 'L''expression est vide';
  SLMDOpenBracketExpected = '"(" attendu';
  SLMDInvalidArgument = 'Argument non valide';
  SLMDMathFunctions = 'Fonctions mathématiques';

  SLMDShowNextTime = 'Affiche la prochaine fois';
  SLMDDSecondsLeft = '%d secondes restantes';

  SElNotIdent = 'Cet entier n'#39'a pas d'#39'identifiant';
  SElInstanceIsNotDefined = 'Instance non définie';
  SElRequiredPropertyIsNotDefined = 'Propriété requise %s non définié';
  SElCantGetThisPropAs = 'Impossible d'#39'obtenir cette propriété avec %s';
  SElCantSetThisPropAs = 'Impossible de définir cette propriété avec %s';
  SElIsNotEnum = 'La propriété %s n'#39'a pas de valeurs';
  SElReadonly = 'La propriété %s est en lecture seule';
  SElInvalidType = 'Transtypage non valide pour %s';
  SElNotFound = '%s %s introuvable';
  SElCompUnassignedValue = '';
  SElClassUnassignedValue = '';

  SLMDNoControl = 'Aucune ScrollBar spécifiée pendant création de l'#39'instance TElScrollBarStyles';

  SLMDNoMoreTokensMessage = 'Aucun token restant';

  SInvalidThemeFileName = 'Nom du fichier thème incorrect [%s]';
  SUnknownTheme = 'Thème inconnu [%s]';
  SUnknownThemePart = 'Partie de thème inconnue [%d]';
  SUnknownThemeColorScheme = 'Couleur de thème inconnue [%s]';
  SUnknownThemeBool = 'Système métrique inconnu. booléen [%d]';
  SUnknownThemeColor = 'Système métrique inconnu. couleur [%d]';
  SUnknownThemeFont = 'Système métrique inconnu. police [%d]';
  SUnknownThemeInt = 'Système métrique inconnu. int [%d]';
  SUnknownThemeSize = 'Système métrique inconnu. taille [%d]';
  SUnknownThemeString = 'Système métrique inconnu. chaine [%d]';
  SInvalidRefCount = 'Valeur RefCount non valide dans [%s]';

  SWinXPThemeNoDisplayName = 'Pas de nom pour ce thème';
  SWinXPThemeInvalidParameter = 'Paramètre de fonction non valide';
  SWinXPThemeNoDocProp = 'La documentation de la propriété [%s] est indéfinie';
  SWinXPThemeNoSchemeSection = 'Impossible de trouver une section appropriée';
  SWinXPThemeNoMetricsProp = 'La propriété [%d] du système métrique est indéfinie';
  SWinXPThemeNoSchemeProp = 'La propriété [%d] du thème est indéfinie';
  SWinXPThemeTextMetricFailed = 'Failed to get text metric';

  SUnkOSError = 'Un appel à une fonction du système a échoué';
  SOSError = 'Erreur système.  Code: %d.'#13#10'%s';

  STExOutOfBounds = 'ElTree index de liste hors limites.';
  STexInvItem = 'ElTree élément non spécifié';
  STexRecursiveMove = 'Impossible de déplacer un élément dans un de ses sous-éléments.';

  SInvalidPropertyValue = 'Valeur de propriété incorrecte';

  SLMDCaption = 'Editeur Image List ';

  SLMDQuestion = 'Choisir un traitement pour cette image';

  SLMDTipOfTheDay = 'Astuce du jour';
  SLMDDidYouKnow = '  Savez-vous...';
  SLMDShowTipsAtStartup = 'Afficher astuces au démarrage';
  SLMDNextTip = '&Astuce suivante';
  SLMDClose = '&Fermer';

  SLMDStyleInstanceNotAssigned  = 'Instance de Style non initialisée pour %s';

const
  LMDElHideSelectTextColor = clBtnShadow;
implementation
end.
