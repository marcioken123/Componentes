unit LMDSysLogStrings;
{###############################################################################

LMDSysLogStrings unit (JH)
-------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring

  // ** TLMDSysWallpaperObject *************************************************
  strWallpaperTile = 'Affichage:Arrière-plan:Mosaïque';
  strWallpaperStretch = 'Affichage:Arrière-plan:Etirer';
  strWallpaperFileName = 'Affichage:Arrière-plan:Nom de fichier';
  strWallpaperPattern = 'Affichage:Arrière-plan:Motif';

  // ** TLMDSysScreensaverObject ***********************************************
  strScreensaverSecure = 'Affichage:Ecran de veille:Protégé';
  strScreensaverDelay = 'Affichage:Ecran de veille:Délai';
  strScreensaverExeName = 'Affichage:Ecran de veille:Exécutable';

  // ** TLMDSysPlusObject ******************************************************
  strPlusFontSmoothing = 'Affichage:Plus:Lissage des polices';
  strPlusWindowAnimation = 'Affichage:Plus:Animation des fenêtres';
  strPlusDragFullWindows = 'Affichage:Plus:Afficher le contenu des fenêtres pendant le déplacement';

  // ** TLMDSysKeyboardObject **************************************************
  strKeyboardSpeed = 'Clavier:Vitesse';
  strKeyboardDelay = 'Clavier:Délai';
  strCaretBlinkTime = 'Clavier:Fréquence de clignotement du curseur';

  // ** TLMDSysLocaleObject ****************************************************
  strCalendarType = 'Options régionnales:Type calendrier';
  strCurrencyDigits = 'Options régionnales:Monétaire - Nombre de décimales';
  strPositiveCurrencyFormat = 'Options régionnales:Monétaire - Format positif';
  strDigits = 'Options régionnales:Nombres - Nombre de décimales';
  strFirstDayOfWeek = 'Options régionnales:Premier jour de la semaine';
  strFirstWeekOfYear = 'Options régionnales:Première semaine de l''année';
  strShowLeadingZero = 'Options régionnales:Afficher les zéros en en-tête';
  strMeasurement = 'Options régionnales:Nombres - Système de mesure';
  strNegativeCurrencyFormat = 'Options régionnales:Monétaire - Format négatif';
  strNegativeFormat = 'Options régionnales:Nombres - Format négatif';
  strClockMode = 'Options régionnales:Mode d''horloge';
  strMorningSymbol = 'Options régionnales:Heure - Symbole AM';
  strAfternoonSymbol = 'Options régionnales:Heure - Symbole PM';
  strCurrencySymbol = 'Options régionnales:Symbole monétaire';
  strDateSeparator = 'Options régionnales:Séparateur de date';
  strDecimalSeparator = 'Options régionnales:Séparateur décimal';
  strGrouping = 'Options régionnales:Groupement des chiffres';
  strListSeparator = 'Options régionnales:Séparateur de listes';
  strLongDateFormat = 'Options régionnales:Format de date longue';
  strCurrencyDecimalSeparator = 'Options régionnales:Monétaire - Séparateur décimal';
  strCurrencyGrouping = 'Options régionnales:Monétaire - Groupement des chiffres';
  strCurrencyGroupingSign = 'Options régionnales:Monétaire - Symbole de groupement des chiffres';
  strNegativeSign = 'Options régionnales:Symbole du signe négatif';
  strPositiveSign = 'Options régionnales:Symbole du signe positif';
  strShortDateFormat = 'Options régionnales:Format de date courte';
  strThousandSeparator = 'Options régionnales:Séparateur des milliers';
  strTimeSeparator = 'Options régionnales:Séparateur horaire';
  strTimeFormat = 'Options régionnales:Format d''heure';
  strShortDateOrder = 'Options régionnales:Ordre date courte';
  strLongDateOrder = 'Options régionnales:Ordre date longue';
  strYearDigits = 'Options régionnales:Nombre de chiffres pour l''année';
  strInternationalCurrencySymbol = 'Options régionnales:Symbole monétaire international';
  strLanguage = 'Options régionnales:Langue';
  strLanguageEnglish = 'Options régionnales:Langue anglaise';
  strLanguageSymbol = 'Options régionnales:Langue symbole';
  strCountryCode = 'Options régionnales:Code du pays';
  strCountry = 'Options régionnales:Pays';
  strCountrySymbol = 'Options régionnales:Symbole du pays';

  // ** TLMDSysMouseObject *****************************************************
  strDoubleClickTime = 'Souris:Vitesse du double-clic';
  strSwapButtons = 'Souris:Permuter les boutons';
  strMouseSpeed = 'Souris:Vitesse du pointeur';
  strMouseSnapToDefault = 'Souris:Déplacer automatiquement sur le bouton par défaut';
  strDoubleClickWidth = 'Souris:Largeur double-clic';
  strDoubleClickHeight = 'Souris:Hauteur double-clic';

  // ** TLMDUninstallItem ******************************************************
  strUninstallProgramName = 'Désinstallation[%d]:Nom du programme';
  strUninstallUninstallPath = 'Désinstallation[%d]:UninstallPath';
  strUninstallPublisher = 'Désinstallation[%d]:Editeur';
  strUninstallPublisherURL = 'Désinstallation[%d]:Site web Editeur';
  strUninstallVersion = 'Désinstallation[%d]:Version';
  strUninstallHelpLink = 'Désinstallation[%d]:HelpLink';
  strUninstallUpdateInfoURL = 'Désinstallation[%d]:UpdateInfoURL';
  strUninstallRegCompany = 'Désinstallation[%d]:RegCompany';
  strUninstallRegOwner = 'Désinstallation[%d]:RegOwner';

  // ** TLMDSysMultimediaObject ************************************************
  strMMauxVolumeL = 'MMedia:aux[%d]:VolumeG';
  strMMauxVolumeR = 'MMedia:aux[%d]:VolumeD';
  strMMwaveVolumeL = 'MMedia:wave[%d]:VolumeG';
  strMMwaveVolumeR = 'MMedia:wave[%d]:VolumeD';
  strMMmidiVolumeL = 'MMedia:midi[%d]:VolumeG';
  strMMmidiVolumeR = 'MMedia:midi[%d]:VolumeD';

  // ** TLMDModemItem **********************************************************
  strModemUserInit = 'Modem:Commandes d''initialisation';

  // ** TLMDSysFileAssoc *******************************************************
  strFileAssocDescription = 'Types de fichiers[%d]:Description';
  strFileAssocDefIcon = 'Types de fichiers[%d]:DefIconStr';
  strFileAssocActionFile = 'Types de fichiers[%d]:Action[%d]:ActionFile';
implementation

end.
