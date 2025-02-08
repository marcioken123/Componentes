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
  SLMDHintNextYear = 'Ann�e suivante';
  SLMDHintPrevYear = 'Ann�e pr�c�dente';
  SLMDHintNextMonth = 'Mois suivant';
  SLMDHintPrevMonth = 'Mois pr�c�dent';
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
  SLMDSelectAll = 'S�lectionner &tout';

  SLMDShiftP = 'Maj+';
  SLMDAltP = 'Alt+';
  SLMDCtrlP = 'Ctrl+';
  SLMDLeftP = 'Gauche+';
  SLMDRightP = 'Droit+';
  SLMDMiddleP = 'Milieu+';
  SLMDDoubleP = 'Double+';
  SLMDLWinP = 'Win+';
  SLMDRWinP = 'Win+';

  SLMDElCantSetThisEntryAs = 'Impossible de d�finir cette valeur avec %s';
  SLMDElCantGetThisPropAs = 'Impossible d'#39'obtenir cette propri�t� avec %s';
  SLMDElCantSetThisPropAs = 'Impossible de d�finir cette propri�t� avec %s';

  SLMDListIndexOutOfBounds = 'Index de liste [%d] hors limites...';

  SLMDBitmapInvalid = 'L'#39'image Bitmap n'#39'est pas valide';
  SLMDSyntaxError = 'Erreur de syntaxe';
  SLMDCloseBracketExpected = '")" attendu';
  SLMDExpressionEmpty = 'L''expression est vide';
  SLMDOpenBracketExpected = '"(" attendu';
  SLMDInvalidArgument = 'Argument non valide';
  SLMDMathFunctions = 'Fonctions math�matiques';

  SLMDShowNextTime = 'Affiche la prochaine fois';
  SLMDDSecondsLeft = '%d secondes restantes';

  SElNotIdent = 'Cet entier n'#39'a pas d'#39'identifiant';
  SElInstanceIsNotDefined = 'Instance non d�finie';
  SElRequiredPropertyIsNotDefined = 'Propri�t� requise %s non d�fini�';
  SElCantGetThisPropAs = 'Impossible d'#39'obtenir cette propri�t� avec %s';
  SElCantSetThisPropAs = 'Impossible de d�finir cette propri�t� avec %s';
  SElIsNotEnum = 'La propri�t� %s n'#39'a pas de valeurs';
  SElReadonly = 'La propri�t� %s est en lecture seule';
  SElInvalidType = 'Transtypage non valide pour %s';
  SElNotFound = '%s %s introuvable';
  SElCompUnassignedValue = '';
  SElClassUnassignedValue = '';

  SLMDNoControl = 'Aucune ScrollBar sp�cifi�e pendant cr�ation de l'#39'instance TElScrollBarStyles';

  SLMDNoMoreTokensMessage = 'Aucun token restant';

  SInvalidThemeFileName = 'Nom du fichier th�me incorrect [%s]';
  SUnknownTheme = 'Th�me inconnu [%s]';
  SUnknownThemePart = 'Partie de th�me inconnue [%d]';
  SUnknownThemeColorScheme = 'Couleur de th�me inconnue [%s]';
  SUnknownThemeBool = 'Syst�me m�trique inconnu. bool�en [%d]';
  SUnknownThemeColor = 'Syst�me m�trique inconnu. couleur [%d]';
  SUnknownThemeFont = 'Syst�me m�trique inconnu. police [%d]';
  SUnknownThemeInt = 'Syst�me m�trique inconnu. int [%d]';
  SUnknownThemeSize = 'Syst�me m�trique inconnu. taille [%d]';
  SUnknownThemeString = 'Syst�me m�trique inconnu. chaine [%d]';
  SInvalidRefCount = 'Valeur RefCount non valide dans [%s]';

  SWinXPThemeNoDisplayName = 'Pas de nom pour ce th�me';
  SWinXPThemeInvalidParameter = 'Param�tre de fonction non valide';
  SWinXPThemeNoDocProp = 'La documentation de la propri�t� [%s] est ind�finie';
  SWinXPThemeNoSchemeSection = 'Impossible de trouver une section appropri�e';
  SWinXPThemeNoMetricsProp = 'La propri�t� [%d] du syst�me m�trique est ind�finie';
  SWinXPThemeNoSchemeProp = 'La propri�t� [%d] du th�me est ind�finie';
  SWinXPThemeTextMetricFailed = 'Failed to get text metric';

  SUnkOSError = 'Un appel � une fonction du syst�me a �chou�';
  SOSError = 'Erreur syst�me.  Code: %d.'#13#10'%s';

  STExOutOfBounds = 'ElTree index de liste hors limites.';
  STexInvItem = 'ElTree �l�ment non sp�cifi�';
  STexRecursiveMove = 'Impossible de d�placer un �l�ment dans un de ses sous-�l�ments.';

  SInvalidPropertyValue = 'Valeur de propri�t� incorrecte';

  SLMDCaption = 'Editeur Image List ';

  SLMDQuestion = 'Choisir un traitement pour cette image';

  SLMDTipOfTheDay = 'Astuce du jour';
  SLMDDidYouKnow = '  Savez-vous...';
  SLMDShowTipsAtStartup = 'Afficher astuces au d�marrage';
  SLMDNextTip = '&Astuce suivante';
  SLMDClose = '&Fermer';

  SLMDStyleInstanceNotAssigned  = 'Instance de Style non initialis�e pour %s';

const
  LMDElHideSelectTextColor = clBtnShadow;
implementation
end.
