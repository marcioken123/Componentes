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
  strWallpaperTile = 'Affichage:Arri�re-plan:Mosa�que';
  strWallpaperStretch = 'Affichage:Arri�re-plan:Etirer';
  strWallpaperFileName = 'Affichage:Arri�re-plan:Nom de fichier';
  strWallpaperPattern = 'Affichage:Arri�re-plan:Motif';

  // ** TLMDSysScreensaverObject ***********************************************
  strScreensaverSecure = 'Affichage:Ecran de veille:Prot�g�';
  strScreensaverDelay = 'Affichage:Ecran de veille:D�lai';
  strScreensaverExeName = 'Affichage:Ecran de veille:Ex�cutable';

  // ** TLMDSysPlusObject ******************************************************
  strPlusFontSmoothing = 'Affichage:Plus:Lissage des polices';
  strPlusWindowAnimation = 'Affichage:Plus:Animation des fen�tres';
  strPlusDragFullWindows = 'Affichage:Plus:Afficher le contenu des fen�tres pendant le d�placement';

  // ** TLMDSysKeyboardObject **************************************************
  strKeyboardSpeed = 'Clavier:Vitesse';
  strKeyboardDelay = 'Clavier:D�lai';
  strCaretBlinkTime = 'Clavier:Fr�quence de clignotement du curseur';

  // ** TLMDSysLocaleObject ****************************************************
  strCalendarType = 'Options r�gionnales:Type calendrier';
  strCurrencyDigits = 'Options r�gionnales:Mon�taire - Nombre de d�cimales';
  strPositiveCurrencyFormat = 'Options r�gionnales:Mon�taire - Format positif';
  strDigits = 'Options r�gionnales:Nombres - Nombre de d�cimales';
  strFirstDayOfWeek = 'Options r�gionnales:Premier jour de la semaine';
  strFirstWeekOfYear = 'Options r�gionnales:Premi�re semaine de l''ann�e';
  strShowLeadingZero = 'Options r�gionnales:Afficher les z�ros en en-t�te';
  strMeasurement = 'Options r�gionnales:Nombres - Syst�me de mesure';
  strNegativeCurrencyFormat = 'Options r�gionnales:Mon�taire - Format n�gatif';
  strNegativeFormat = 'Options r�gionnales:Nombres - Format n�gatif';
  strClockMode = 'Options r�gionnales:Mode d''horloge';
  strMorningSymbol = 'Options r�gionnales:Heure - Symbole AM';
  strAfternoonSymbol = 'Options r�gionnales:Heure - Symbole PM';
  strCurrencySymbol = 'Options r�gionnales:Symbole mon�taire';
  strDateSeparator = 'Options r�gionnales:S�parateur de date';
  strDecimalSeparator = 'Options r�gionnales:S�parateur d�cimal';
  strGrouping = 'Options r�gionnales:Groupement des chiffres';
  strListSeparator = 'Options r�gionnales:S�parateur de listes';
  strLongDateFormat = 'Options r�gionnales:Format de date longue';
  strCurrencyDecimalSeparator = 'Options r�gionnales:Mon�taire - S�parateur d�cimal';
  strCurrencyGrouping = 'Options r�gionnales:Mon�taire - Groupement des chiffres';
  strCurrencyGroupingSign = 'Options r�gionnales:Mon�taire - Symbole de groupement des chiffres';
  strNegativeSign = 'Options r�gionnales:Symbole du signe n�gatif';
  strPositiveSign = 'Options r�gionnales:Symbole du signe positif';
  strShortDateFormat = 'Options r�gionnales:Format de date courte';
  strThousandSeparator = 'Options r�gionnales:S�parateur des milliers';
  strTimeSeparator = 'Options r�gionnales:S�parateur horaire';
  strTimeFormat = 'Options r�gionnales:Format d''heure';
  strShortDateOrder = 'Options r�gionnales:Ordre date courte';
  strLongDateOrder = 'Options r�gionnales:Ordre date longue';
  strYearDigits = 'Options r�gionnales:Nombre de chiffres pour l''ann�e';
  strInternationalCurrencySymbol = 'Options r�gionnales:Symbole mon�taire international';
  strLanguage = 'Options r�gionnales:Langue';
  strLanguageEnglish = 'Options r�gionnales:Langue anglaise';
  strLanguageSymbol = 'Options r�gionnales:Langue symbole';
  strCountryCode = 'Options r�gionnales:Code du pays';
  strCountry = 'Options r�gionnales:Pays';
  strCountrySymbol = 'Options r�gionnales:Symbole du pays';

  // ** TLMDSysMouseObject *****************************************************
  strDoubleClickTime = 'Souris:Vitesse du double-clic';
  strSwapButtons = 'Souris:Permuter les boutons';
  strMouseSpeed = 'Souris:Vitesse du pointeur';
  strMouseSnapToDefault = 'Souris:D�placer automatiquement sur le bouton par d�faut';
  strDoubleClickWidth = 'Souris:Largeur double-clic';
  strDoubleClickHeight = 'Souris:Hauteur double-clic';

  // ** TLMDUninstallItem ******************************************************
  strUninstallProgramName = 'D�sinstallation[%d]:Nom du programme';
  strUninstallUninstallPath = 'D�sinstallation[%d]:UninstallPath';
  strUninstallPublisher = 'D�sinstallation[%d]:Editeur';
  strUninstallPublisherURL = 'D�sinstallation[%d]:Site web Editeur';
  strUninstallVersion = 'D�sinstallation[%d]:Version';
  strUninstallHelpLink = 'D�sinstallation[%d]:HelpLink';
  strUninstallUpdateInfoURL = 'D�sinstallation[%d]:UpdateInfoURL';
  strUninstallRegCompany = 'D�sinstallation[%d]:RegCompany';
  strUninstallRegOwner = 'D�sinstallation[%d]:RegOwner';

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
