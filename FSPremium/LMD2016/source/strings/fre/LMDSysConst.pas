unit LMDSysConst;
{###############################################################################

LMDSysConst unit (JH)
---------------------
Resource strings for LMD SysPack.
Translation by David Le Franc. 

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  sLMDSysNOTAVAILABLE='n/a';
  sLMDSysNone='Aucun';
  sLMDSysFirst='1er';
  sLMDSysSecond='2�me';
  sLMDSysThird='3�me';
  sLMDSysFourth='4�me';
  sLMDSysLast='Dernier';
  sLMDSysUnknown = 'Inconnu';
  sLMDSysof = 'de';

  // Center
  cLMDSysInfoTitle = 'Centre d''informations syst�me';
  cLMDSysInfoDesc = '';

  // DriveTypes
  sLMDSysNOROOTDIR = 'Pas de dossier racine';
  sLMDSysREMOVABLE = 'Disquette';
  sLMDSysFIXEDDRIVE = 'Fixe';
  sLMDSysREMOTE = 'R�seau';
  sLMDSysCDROM = 'CD-ROM';
  sLMDSysRAMDISK = 'RAM';

  //TLMDSysWindowsObject
  sLMDSysElapsedTime='%d jours %d heures %d minutes %d secondes';
  // Network
  sLMDSysNetwork='R�seau';

  // Event Log
  sLMDSysMessageDLLNOTFOUNT='DLL de ressources, pour localisation des messages, non trouv�e';
  sLMDSysEventDlgError='Pas de journal des �v�nements ou �l�ment(s) inexistant(s).';
  sLMDSysEventNotOpen='Journal des �v�nements non ouvert';

  sLMDsysEventTypeError='Erreur';
  sLMDsysEventTypeWarning='Attention';
  sLMDsysEventTypeInformation='Information';
  sLMDsysEventTypeAuditSuccess='Succ�s de l''audit';
  sLMDsysEventTypeAuditFailure='Echec de l''audit';

  sLMDSysEventEvent='Ev�nement';
  sLMDSysEventDate='Date';
  sLMDSysEventTime='Heure';
  sLMDSysEventType='Type';
  sLMDSysEventSource='Source';
  sLMDSysEventUser='Utilisateur';
  sLMDSysEventCategory='Cat�gorie';
  sLMDSysEventComputer='Ordinateur';

  sLMDSysEventDlgCaption='D�tails de l''�v�nement';
  sLMDSysEventDlgEventIDLabel='ID �v�nement:';
  sLMDSysEventDlgDescriptionLabel='Description:';

  // System Folder Names:
  sLMDSysFolderDesktop='Bureau';
  sLMDSysFolderPrograms='Programmes';
  sLMDSysFolderControlPanel='Panneau de configuration';
  sLMDSysFolderPrinters='Imprimantes';
  sLMDSysFolderPersonal='Mes documents';
  sLMDSysFolderFavorites='Favoris';
  sLMDSysFolderStartup='D�marrer';
  sLMDSysFolderRecent='Documents r�cents';
  sLMDSysFolderSendto='Envoyer vers';
  sLMDSysFolderRecycleBin='Corbeille';
  sLMDSysFolderStartMenu='Menu d�marrer';
  sLMDSysFolderDesktopDirectory='DesktopDirectory';
  sLMDSysFolderMyComputer='Poste de travail';
  sLMDSysFolderNetwork='R�seau';
  sLMDSysFolderNetworkNeighborhood='Voisinage r�seau';
  sLMDSysFolderInternet='Internet';
  sLMDSysFolderFonts='Polices';
  sLMDSysFolderTemplates='Templates';
  sLMDSysFolderCommonStartMenu='CommonStartMenu';
  sLMDSysFolderCommonPrograms='CommonPrograms';
  sLMDSysFolderCommonStartup='CommonStartup';
  sLMDSysFolderCommonDesktopDirectory='CommonDesktopDirectory';
  sLMDSysFolderAppData='AppData';
  sLMDSysFolderPrintHood='PrintHood';
  sLMDSysFolderAltStartup='AltStartup';
  sLMDSysFolderCommonAltstartup='CommonAltstartup';
  sLMDSysFolderCommonFavorites='CommonFavorites';
  sLMDSysFolderInternetCache='InternetCache';
  sLMDSysFolderCookies='Cookies';
  sLMDSysFolderHistory='History';
  sLMDSysFolderMyVideo='Mes vid�os';
  sLMDSysFolderCommonVideo='CommonVideo';
  sLMDSysFolderMyPictures='Mes images';
  sLMDSysFolderCommonPictures='CommonPictures';
  sLMDSysFolderMyMusic='Ma musique';
  sLMDSysFolderCommonMusic='CommonMusic';
  sLMDSysFolderMyDocuments='Mes documents';
  sLMDSysFolderAdminTools='AdminTools';
  sLMDSysFolderCommonAdminTools='CommonAdminTools';
  sLMDSysFolderBurnArea='BurnArea';
  sLMDSysFolderProfile='Profile';
  sLMDSysFolderProfiles='Profiles';
  sLMDSysFolderProgramFiles='ProgramFiles';
  sLMDSysFolderCommonProgramFiles='CommonProgramFiles';
  sLMDSysFolderWindows='Windows';
  sLMDSysFolderSystem='System';

  // Strings for SysInfoView controls
  // ===========================================================================

  // Mouse object section
  sLMDSysMouseObjectTitle = 'Souris';
    sLMDSysMouseObjectDesc = 'P�riph�rique de pointage';
  sLMDSysMousePropTitleDoubleClickTime = 'Vitesse du double-clic';
    sLMDSysMousePropDescDoubleClickTime = 'Vitesse du double-clic';
  sLMDSysMousePropTitleDoubleClickWidth = 'Largeur double-clic';
    sLMDSysMousePropDescDoubleClickWidth = 'Largeur, en pixels, du rectangle autour de la position du premier clic lors d''un double-clic';
  sLMDSysMousePropTitleDoubleClickHeight = 'Hauteur double-clic';
    sLMDSysMousePropDescDoubleClickHeight = 'Hauteur, en pixels, du rectangle autour de la position du premier clic lors d''''un double-clic';
  sLMDSysMousePropTitleSpeed = 'Vitesse';
    sLMDSysMousePropDescSpeed = 'Vitesse de mouvement du pointeur';
  sLMDSysMousePropTitleButtons = 'Boutons';
    sLMDSysMousePropDescButtons = 'Nombre de boutons de la souris';
  sLMDSysMousePropTitleSwapButtons = 'Inversion des boutons';
    sLMDSysMousePropDescSwapButtons = 'Indique que les boutons principal et secondaire sont permut�s';
  sLMDSysMousePropTitleExist = 'Souris disponible';
    sLMDSysMousePropDescExist = 'Indique que la souris est disponible';
  sLMDSysMousePropTitleHasWheel = 'Roulette disponible';
    sLMDSysMousePropDescHasWheel = 'Indique que la souris dispose d''une roulette';
  sLMDSysMousePropTitleSnapToDefault = 'D�placement sur le bouton par d�faut';
    sLMDSysMousePropDescSnapToDefault = 'Indique si le d�placement sur le bouton par d�faut est activ�';
  sLMDSysMousePropTitleCursorScheme = 'Mod�le';
    sLMDSysMousePropDescCursorScheme = 'Mod�le';
  sLMDSysMousePropTitleCursorSchemes = 'Mod�les de pointeurs';
    sLMDSysMousePropDescCursorSchemes = 'Mod�les de pointeurs';

  sLMDSysMousePropTitleAvailability = 'Disponibilit�';
    sLMDSysMousePropDescAvailability = '';
  sLMDSysMousePropTitleConfigManagerErrorCode = 'ConfigManagerErrorCode';
    sLMDSysMousePropDescConfigManagerErrorCode = '';
  sLMDSysMousePropTitleConfigManagerUserConfig = 'ConfigManagerUserConfig';
    sLMDSysMousePropDescConfigManagerUserConfig = '';
  sLMDSysMousePropTitleDeviceID = 'DeviceID';
    sLMDSysMousePropDescDeviceID = '';
  sLMDSysMousePropTitleDoubleSpeedThreshold = 'DoubleSpeedThreshold';
    sLMDSysMousePropDescDoubleSpeedThreshold = '';
  sLMDSysMousePropTitleErrorCleared = 'ErrorCleared';
    sLMDSysMousePropDescErrorCleared = '';
  sLMDSysMousePropTitleErrorDescription = 'ErrorDescription';
    sLMDSysMousePropDescErrorDescription = '';
  sLMDSysMousePropTitleHardwareType = 'Type de mat�riel';
    sLMDSysMousePropDescHardwareType = '';
  sLMDSysMousePropTitleInfFileName = 'InfFileName';
    sLMDSysMousePropDescInfFileName = '';
  sLMDSysMousePropTitleInfSection = 'InfSection';
    sLMDSysMousePropDescInfSection = '';
  sLMDSysMousePropTitleInstallDate = 'Date d''installation';
    sLMDSysMousePropDescInstallDate = '';
  sLMDSysMousePropTitleIsLocked = 'IsLocked';
    sLMDSysMousePropDescIsLocked = '';
  sLMDSysMousePropTitleLastErrorCode = 'LastErrorCode';
    sLMDSysMousePropDescLastErrorCode = '';
  sLMDSysMousePropTitleManufacturer = 'Fabricant';
    sLMDSysMousePropDescManufacturer = '';
  sLMDSysMousePropTitleName = 'Nom';
    sLMDSysMousePropDescName = '';
  sLMDSysMousePropTitlePowerManagementCapabilities = 'PowerManagementCapabilities';
    sLMDSysMousePropDescPowerManagementCapabilities = '';
  sLMDSysMousePropTitlePowerManagementSupported = 'PowerManagementSupported';
    sLMDSysMousePropDescPowerManagementSupported = '';
  sLMDSysMousePropTitleQuadSpeedThreshold = 'QuadSpeedThreshold';
    sLMDSysMousePropDescQuadSpeedThreshold = '';
  sLMDSysMousePropTitleResolution = 'R�solution';
    sLMDSysMousePropDescResolution = '';
  sLMDSysMousePropTitleSampleRate = 'SampleRate';
    sLMDSysMousePropDescSampleRate = '';
  sLMDSysMousePropTitleStatus = 'Statut';
    sLMDSysMousePropDescStatus = '';
  sLMDSysMousePropTitleStatusInfo = 'Information';
    sLMDSysMousePropDescStatusInfo = '';
  sLMDSysMousePropTitleSynch = 'Synch';
    sLMDSysMousePropDescSynch = '';


  // Display section
  sLMDSysDisplayObjectTitle = 'Affichage';
    sLMDSysDisplayObjectDesc = 'P�riph�rique d''affichage';
  sLMDSysDisplayModeObjectTitle = 'Mode d''affichage';
    sLMDSysDisplayModeObjectDesc = 'Mode d''affichage';
  sLMDSysDisplayPlusObjectTitle = 'Plus';
    sLMDSysDisplayPlusObjectDesc = 'Plus';
  sLMDSysDisplayScreenSaverObjectTitle = 'Ecran de veille';
    sLMDSysDisplayScreenSaverObjectDesc = 'Ecran de veille';
  sLMDSysDisplayWallpaperObjectTitle = 'Papier peint';
    sLMDSysDisplayWallpaperObjectDesc = 'Papier peint';

  sLMDSysDisplayModePropTitleWidth = 'Largeur';
    sLMDSysDisplayModePropDescWidth = '';
  sLMDSysDisplayModePropTitleHeight = 'Hauteur';
    sLMDSysDisplayModePropDescHeight = '';
  sLMDSysDisplayModePropTitleFrequency = 'Fr�quence';
    sLMDSysDisplayModePropDescFrequency = '';
  sLMDSysDisplayModePropTitleBitsPerPixel = 'Bits par pixel';
    sLMDSysDisplayModePropDescBitsPerPixel = '';
  sLMDSysDisplayModePropTitleMonochrome = 'Monochrome';
    sLMDSysDisplayModePropDescMonochrome = '';
  sLMDSysDisplayModePropTitleInterlaced = 'Entrelac�';
    sLMDSysDisplayModePropDescInterlaced = '';
  sLMDSysDisplayModePropTitleColors = 'Couleurs';
    sLMDSysDisplayModePropDescColors = '';

  sLMDSysDisplayPlusPropTitleAvailable = 'Disponible';
    sLMDSysDisplayPlusPropDescAvailable = '';
  sLMDSysDisplayPlusPropTitleFontSmoothing = 'Lissage des polices';
    sLMDSysDisplayPlusPropDescFontSmoothing = '';
  sLMDSysDisplayPlusPropTitleWindowAnimation = 'Animation des fen�tres';
    sLMDSysDisplayPlusPropDescWindowAnimation = '';
  sLMDSysDisplayPlusPropTitleDragFullWindows = 'Afficher le contenu des fen�tres pendant le d�placement';
    sLMDSysDisplayPlusPropDescDragFullWindows = '';

  sLMDSysDisplayScreenSaverPropTitleActive = 'Actif';
    sLMDSysDisplayScreenSaverPropDescActive = '';
  sLMDSysDisplayScreenSaverPropTitleDelay = 'D�lai';
    sLMDSysDisplayScreenSaverPropDescDelay = '';
  sLMDSysDisplayScreenSaverPropTitleSecure = 'Prot�g�';
    sLMDSysDisplayScreenSaverPropDescSecure = '';
  sLMDSysDisplayScreenSaverPropTitleRunning = 'En cours';
    sLMDSysDisplayScreenSaverPropDescRunning = '';
  sLMDSysDisplayScreenSaverPropTitleScreenSaver = 'Economiseur';
    sLMDSysDisplayScreenSaverPropDescScreenSaver = '';
  sLMDSysDisplayScreenSaverPropTitleScreenSavers = 'Economiseurs';
    sLMDSysDisplayScreenSaverPropDescScreenSavers = '';

  sLMDSysDisplayWallpaperPropTitleFilename = 'Fichier';
    sLMDSysDisplayWallpaperPropDescFilename = '';
  sLMDSysDisplayWallpaperPropTitleTile = 'Mosa�que';
    sLMDSysDisplayWallpaperPropDescTile = '';
  sLMDSysDisplayWallpaperPropTitleStretch = 'Etirer';
    sLMDSysDisplayWallpaperPropDescStretch = '';
  sLMDSysDisplayWallpaperPropTitlePatterns = 'Motifs';
    sLMDSysDisplayWallpaperPropDescPatterns = '';
  sLMDSysDisplayWallpaperPropTitlePattern = 'Motif';
    sLMDSysDisplayWallpaperPropDescPattern = '';

  // Drive object section
  sLMDSysDriveObjectTitle = 'Disque';
    sLMDSysDriveObjectDesc = 'Disque';

  sLMDSysDrivePropTitleBytesPerSector = 'Octets par secteur';
    sLMDSysDrivePropDescBytesPerSector = '';
  sLMDSysDrivePropTitleDiskSize = 'Taille';
    sLMDSysDrivePropDescDiskSize = '';
  sLMDSysDrivePropTitleDiskFree = 'Espace libre';
    sLMDSysDrivePropDescDiskFree = '';
  sLMDSysDrivePropTitleDrive = 'Disque';
    sLMDSysDrivePropDescDrive = '';
  sLMDSysDrivePropTitleDriveType = 'Type';
    sLMDSysDrivePropDescDriveType = '';
  sLMDSysDrivePropTitleFileSystem = 'Syst�me de fichier';
    sLMDSysDrivePropDescFileSystem = '';
  sLMDSysDrivePropTitleSectorsPerCluster = 'Secteurs par cluster';
    sLMDSysDrivePropDescSectorsPerCluster = '';
  sLMDSysDrivePropTitleMaximumLength = 'MaximumLength';
    sLMDSysDrivePropDescMaximumLength = '';
  sLMDSysDrivePropTitleSerialNumber = 'Num�ro de s�rie';
    sLMDSysDrivePropDescSerialNumber = '';
  sLMDSysDrivePropTitleOptions = 'Options';
    sLMDSysDrivePropDescOptions = '';
  sLMDSysDrivePropTitleVolumeLabel = 'Nom du volume';
    sLMDSysDrivePropDescVolumeLabel = '';

  sLMDSysDriveOptionCaseIsPreserved = 'La casse est pr�serv�e';
  sLMDSysDriveOptionCaseSensitive = 'Diff�renciation MAJ/min';
  sLMDSysDriveOptionSupportsUnicode = 'Support d''Unicode';
  sLMDSysDriveOptionPersistentACLs = 'ACLs persistants';
  sLMDSysDriveOptionSupportsCompression = 'Support de la compression';
  sLMDSysDriveOptionIsCompressed = 'Est compress�';
  sLMDSysDriveOptionSupportsQuotas = 'Support des quotas';

// Services Section
  sLMDSysServiceObjectTitle = 'Service';
  sLMDSysServiceObjectDesc = '';

  sLMDSysServicePropTitleDisplayName = 'Display name';
  sLMDSysServicePropTitleServiceName = 'Service name';
  sLMDSysServicePropTitleBinaryPath = 'Binary path';
  sLMDSysServicePropTitleLoadOrderGroup = 'Load order group';
  sLMDSysServicePropTitleServiceStartName = 'Service start name';
  sLMDSysServicePropTitleTagId = 'TagId';
  sLMDSysServicePropTitleServiceTypes = 'Service types';
  sLMDSysServicePropTitleCurrentState = 'Current state';
  sLMDSysServicePropTitleStartType = 'Start type';

  sLMDSysServicePropDescDisplayName = '';
  sLMDSysServicePropDescServiceName = '';
  sLMDSysServicePropDescBinaryPath = '';
  sLMDSysServicePropDescLoadOrderGroup = '';
  sLMDSysServicePropDescServiceStartName = '';
  sLMDSysServicePropDescTagId = '';
  sLMDSysServicePropDescServiceTypes = '';
  sLMDSysServicePropDescCurrentState = '';
  sLMDSysServicePropDescStartType = '';

  sLMDSysServiceContinuePending = 'Continue Pending';
  sLMDSysServicePausePending = 'Pause Pending';
  sLMDSysServicePaused = 'Paused';
  sLMDSysServiceRunning = 'Running';
  sLMDSysServiceStartPending = 'Start Pending';
  sLMDSysServiceStopPending = 'Stop Pending';
  sLMDSysServiceStopped = 'Stopped';

  sLMDSysServiceStartAutoStart = 'Auto start';
  sLMDSysServiceStartBootStart = 'Boot start';
  sLMDSysServiceStartDemandStart = 'Demand start';
  sLMDSysServiceStartDisabled = 'Disabled';
  sLMDSysServiceStartSystemStart = 'System start';

  sLMDSysServiceTypeFileSystemDriver = 'File system driver';
  sLMDSysServiceTypeKernelDriver = 'Kernel driver';
  sLMDSysServiceTypeWin32OwnProcess = 'Win32 own process';
  sLMDSysServiceTypeWin32ShareProcess = 'Win32 share process';
  sLMDSysServiceTypeInteractiveProcess = 'Interactive process';


  // Printer Section
  sLMDSysPrinterObjectsTitle = 'Imprimantes';
    sLMDSysPrinterObjectsDesc = '';
  sLMDSysPrinterObjectTitle = 'Imprimante';
    sLMDSysPrinterObjectDesc = '';

  sLMDSysPrinterPropTitleDeviceName = 'Nom du p�riph�rique';
    sLMDSysPrinterPropDescDeviceName = '';
  sLMDSysPrinterPropTitleDriver = 'Pilote';
    sLMDSysPrinterPropDescDriver = '';
  sLMDSysPrinterPropTitleComment = 'Commentaire';
    sLMDSysPrinterPropDescComment = '';
  sLMDSysPrinterPropTitleLocation = 'Location';
    sLMDSysPrinterPropDescLocation = '';
  sLMDSysPrinterPropTitlePort = 'Port';
    sLMDSysPrinterPropDescPort = '';
  sLMDSysPrinterPropTitleServer = 'Serveur';
    sLMDSysPrinterPropDescServer = '';
  sLMDSysPrinterPropTitleDataType = 'Type de donn�e';
    sLMDSysPrinterPropDescDataType = '';
  sLMDSysPrinterPropTitlePrintProcessor = 'Processeur';
    sLMDSysPrinterPropDescPrintProcessor = '';
  sLMDSysPrinterPropTitlePrintProcessorParams = 'Param�tres du processeur d''impression';
    sLMDSysPrinterPropDescPrintProcessorParams = '';
  sLMDSysPrinterPropTitleSepFile = 'SepFile';
    sLMDSysPrinterPropDescSepFile = '';
  sLMDSysPrinterPropTitleStartTime = 'StartTime';
    sLMDSysPrinterPropDescStartTime = '';
  sLMDSysPrinterPropTitleUntilTime = 'UntilTime';
    sLMDSysPrinterPropDescUntilTime = '';
  sLMDSysPrinterPropTitleDriverVersion = 'Version du pilote';
    sLMDSysPrinterPropDescDriverVersion = '';
  sLMDSysPrinterPropTitleDuplex = 'Duplex';
    sLMDSysPrinterPropDescDuplex = '';
  sLMDSysPrinterPropTitleOrientation = 'Orientation';
    sLMDSysPrinterPropDescOrientation = '';
  sLMDSysPrinterPropTitlePaperSize = 'Taille du papier';
    sLMDSysPrinterPropDescPaperSize = '';
  sLMDSysPrinterPropTitleQuality = 'Qualit�';
    sLMDSysPrinterPropDescQuality = '';
  sLMDSysPrinterPropTitleScale = 'Echelle';
    sLMDSysPrinterPropDescScale = '';
  sLMDSysPrinterPropTitleCopies = 'Copies';
    sLMDSysPrinterPropDescCopies = '';
  sLMDSysPrinterPropTitleTrueTypeOption = 'Option True Type';
    sLMDSysPrinterPropDescTrueTypeOption = '';
  sLMDSysPrinterPropTitleCollate = 'Copies assembl�es';
    sLMDSysPrinterPropDescCollate = '';
  sLMDSysPrinterPropTitleCustomXRes = 'CustomXRes';
    sLMDSysPrinterPropDescCustomXRes = '';
  sLMDSysPrinterPropTitleCustomYRes = 'CustomYRes';
    sLMDSysPrinterPropDescCustomYRes = '';
  sLMDSysPrinterPropTitlePaperLength = 'Longueur papier';
    sLMDSysPrinterPropDescPaperLength = '';
  sLMDSysPrinterPropTitlePaperWidth = 'Largeur papier';
    sLMDSysPrinterPropDescPaperWidth = '';
  sLMDSysPrinterPropTitleValidFlags = 'ValidFlags';
    sLMDSysPrinterPropDescValidFlags = '';
  sLMDSysPrinterPropTitleMonochrome = 'Monochrome';
    sLMDSysPrinterPropDescMonochrome = '';
  sLMDSysPrinterPropDefaultBin = 'DefalutSource';
    sLMDSysPrinterPropDescDefaultBin = '';
  sLMDSysPrinterPropAvailableBins = 'AvailableBins';
    sLMDSysPrinterPropDescAvailableBins = '';


  sLMDSysPrinterDuplexSimplex = 'Simplex';
  sLMDSysPrinterDuplexHorizontal = 'Horizontal';
  sLMDSysPrinterDuplexVertical = 'Vertical';
  sLMDSysPrinterOrientationPortrait = 'Portrait';
  sLMDSysPrinterOrientationLandscape = 'Paysage';
  sLMDSysPrinterQualityHigh = 'Haut';
  sLMDSysPrinterQualityMedium = 'Moyen';
  sLMDSysPrinterQualityLow = 'Bas';
  sLMDSysPrinterQualityDraft = 'Brouillon';
  sLMDSysPrinterQualityCustom = 'Personnalis�';

  sLMDSysPrinterPaperSizeCustom = 'Personnalis�';
  sLMDSysPrinterPaperSizeLETTER = 'Lettre 8,5 x 11 pouces';
  sLMDSysPrinterPaperSizeLEGAL = 'L�gal, 8,5 x 14 pouces';
  sLMDSysPrinterPaperSizeA4 = 'Feuille A4, 210 x 297 mm';
  sLMDSysPrinterPaperSizeCSHEET = 'Feuille C, 17 x 22 pouces';
  sLMDSysPrinterPaperSizeDSHEET = 'Feuille D, 22 x 34 pouces';
  sLMDSysPrinterPaperSizeESHEET = 'Feuille E, 34 x 44 pouces';
  sLMDSysPrinterPaperSizeLETTERSMALL = 'Petite lettre, 8,5 x 11 pouces';
  sLMDSysPrinterPaperSizeTABLOID = 'Tabloide, 11 x 17 pouces';
  sLMDSysPrinterPaperSizeLEDGER = 'Ledger, 17 x 11 pouces';
  sLMDSysPrinterPaperSizeSTATEMENT = 'Statement, 5,5 x 8,5 pouces';
  sLMDSysPrinterPaperSizeEXECUTIVE = 'Executive, 7,25 x 10,5 pouces';
  sLMDSysPrinterPaperSizeA3 = 'Feuille A3, 297 x 420 mm';
  sLMDSysPrinterPaperSizeA4SMALL = 'Petite feuille A4, 210 x 297 mm';
  sLMDSysPrinterPaperSizeA5 = 'Feuille A5, 148 x 210 mm';
  sLMDSysPrinterPaperSizeB4 = 'Feuille B4, 250 x 354 mm';
  sLMDSysPrinterPaperSizeB5 = 'Feuille B5, 182 x 257 mm';
  sLMDSysPrinterPaperSizeFOLIO = 'Folio, 8 1/2 x 13 pouces';
  sLMDSysPrinterPaperSizeQUARTO = 'Quarto, 215 x 275 mm';
  sLMDSysPrinterPaperSize10X14 = 'Feuille 10 x 14 pouces';
  sLMDSysPrinterPaperSize11X17 = 'Feuille 11 x 17 pouces';
  sLMDSysPrinterPaperSizeNOTE = 'Note, 8,5 x 11 pouces';
  sLMDSysPrinterPaperSizeENV_9 = 'Enveloppe #9, 3 7/8 x 8 7/8 pouces';
  sLMDSysPrinterPaperSizeENV_10 = 'Enveloppe #10, 4 1/8 x 9,5 pouces';
  sLMDSysPrinterPaperSizeENV_11 = 'Enveloppe #11, 4 1/2 x 10 3/8 pouces';
  sLMDSysPrinterPaperSizeENV_12 = 'Enveloppe #12, 4 3/4 x 11 pouces';
  sLMDSysPrinterPaperSizeENV_14 = 'Enveloppe #14, 5 x 11,5 pouces';
  sLMDSysPrinterPaperSizeENV_DL = 'Enveloppe DL, 110 x 220 mm';
  sLMDSysPrinterPaperSizeENV_C5 = 'Enveloppe C5, 162 x 229 mm';
  sLMDSysPrinterPaperSizeENV_C3 = 'Enveloppe C3,  324 x 458 mm';
  sLMDSysPrinterPaperSizeENV_C4 = 'Enveloppe C4,  229 x 324 mm';
  sLMDSysPrinterPaperSizeENV_C6 = 'Enveloppe C6,  114 x 162 mm';
  sLMDSysPrinterPaperSizeENV_C65 = 'Enveloppe C65, 114 x 229 mm';
  sLMDSysPrinterPaperSizeENV_B4 = 'Enveloppe B4,  250 x 353 mm';
  sLMDSysPrinterPaperSizeENV_B5 = 'Enveloppe B5,  176 x 250 mm';
  sLMDSysPrinterPaperSizeENV_B6 = 'Enveloppe B6,  176 x 125 mm';
  sLMDSysPrinterPaperSizeENV_ITALY = 'Enveloppe Italy, 110 x 230 mm';
  sLMDSysPrinterPaperSizeENV_MONARCH = 'Enveloppe Monarch, 3 7/8 x 7,5 pouces';
  sLMDSysPrinterPaperSizeENV_PERSONAL = 'Enveloppe 6 3/4, 3 5/8 x 6,5 pouces';
  sLMDSysPrinterPaperSizeFANFOLD_US = 'US Std Fanfold, 14 7/8 x 11 pouces';
  sLMDSysPrinterPaperSizeFANFOLD_STD_GERMAN = 'German Std Fanfold, 8,5 x 12 pouces';
  sLMDSysPrinterPaperSizeFANFOLD_LGL_GERMAN = 'German Legal Fanfold, 8,5 x 13 pouces';
  sLMDSysPrinterOptionBitmap = 'Bitmap';
  sLMDSysPrinterOptionDownload = 'Chargement';
  sLMDSysPrinterOptionSubDev = 'SubDev';

  sLMDSysPrinterValidFlagORIENTATION = 'ORIENTATION';
  sLMDSysPrinterValidFlagPAPERSIZE = 'TAILLE DU PAPIER';
  sLMDSysPrinterValidFlagPAPERLENGTH = 'LONGUEUR DU PAPIER';
  sLMDSysPrinterValidFlagPAPERWIDTH = 'LARGEUR DU PAPIER';
  sLMDSysPrinterValidFlagSCALE = 'ECHELLE';
  sLMDSysPrinterValidFlagCOPIES = 'COPIES';
  sLMDSysPrinterValidFlagPRINTQUALITY = 'QUALITE D''IMPRESSION';
  sLMDSysPrinterValidFlagCOLOR = 'COULEUR';
  sLMDSysPrinterValidFlagDUPLEX = 'DUPLEX';
  sLMDSysPrinterValidFlagYRESOLUTION = 'RESOLUTION Y';
  sLMDSysPrinterValidFlagTTOPTION = 'TRUETYPE';
  sLMDSysPrinterValidFlagCOLLATE = 'ASSEMBLEES';

  // TLMDSysWindowsObject Display Strings
  // -------------------------------------
  sLMDSysWindowsObjectsTitle = 'Windows';
    sLMDSysWindowsObjectsDesc = '';
  sLMDSysWinPropTitleRegisteredOwner = 'Propri�taire enregistr�';
    sLMDSysWinPropDescRegisteredOwner = '';
  sLMDSysWinPropTitleRegisteredCompany = 'Entreprise enregistr�e';
    sLMDSysWinPropDescRegisteredCompany = '';
  sLMDSysWinPropTitleProductName = 'Nom du produit';
    sLMDSysWinPropDescProductName = '';
  sLMDSysWinPropTitleProductID = 'Id du product';
    sLMDSysWinPropDescProductID = '';
  sLMDSysWinPropTitleProductType = 'Type du produit';
    sLMDSysWinPropDescProductType = '';
  sLMDSysWinPropTitleProductSuite = 'Product Suit Ident';
    sLMDSysWinPropDescProductSuite = '';
  sLMDSysWinPropTitleProductVersion = 'Version du produit';
    sLMDSysWinPropDescProductVersion = '';
  sLMDSysWinPropTitleVersionName = 'Version';
    sLMDSysWinPropDescVersionName = '';
  sLMDSysWinPropTitleServicePackMajor = 'Version majeure du service pack';
    sLMDSysWinPropDescServicePackMajor = '';
  sLMDSysWinPropTitleServicePackMinor = 'Version mineure du service pack';
    sLMDSysWinPropDescServicePackMinor = '';
  sLMDSysWinPropTitleUpTimeString = 'Up Time';
    sLMDSysWinPropDescUpTimeString = '';
  sLMDSysWinPropTitleLastBoot = 'Dernier d�marrage';
    sLMDSysWinPropDescLastBoot = '';
  sLMDSysWinPropTitleSystemFolders = 'Dossiers syst�me';
    sLMDSysWinPropDescSystemFolders = '';
  sLMDSysWinPropTitleWinDir = 'Dossier Windows';
    sLMDSysWinPropDescWinDir = '';
  sLMDSysWinPropTitleSysDir = 'Dossier System';
    sLMDSysWinPropDescSysDir = '';
  sLMDSysWinPropTitleTempDir = 'Dossier temporaire';
    sLMDSysWinPropDescTempDir = '';
  sLMDSysWinPropTitleEnvironment = 'Environnement';
    sLMDSysWinPropDescEnvironment = '';
  sLMDSysWinPropTitleInstallDate = 'Date d''installation';
    sLMDSysWinPropDescInstallDate = '';
  sLMDSysWinPropTitleCSDVersion = 'CSDVersion';
    sLMDSysWinPropDescCSDVersion = '';
  sLMDSysWinPropTitlePlatformID = 'Id plate-forme';
    sLMDSysWinPropDescPlatformID = '';
  sLMDSysWinPropTitleBuildNumber = 'Build';
    sLMDSysWinPropDescBuildNumber = '';
  sLMDSysWinPropTitleMajorVersion = 'Version majeure';
    sLMDSysWinPropDescMajorVersion = '';
  sLMDSysWinPropTitleMinorVersion = 'Version mineure';
    sLMDSysWinPropDescMinorVersion = '';

    //KEYBOARD SECTION
  sLMDSysKeyboardObjectsTitle = 'Clavier';
    sLMDSysKeyboardObjectsDesc = '';

  sLMDKeyboard1 ='Clavier IBM PC/XT ou compatible (83-key)';
  sLMDKeyboard2 ='Clavier Olivetti "ICO" (102-key)';
  sLMDKeyboard3 ='Clavier IBM PC/AT (84-key) ou similaire';
  sLMDKeyboard4 ='Clavier IBM enhanced (101- or 102-key)';
  sLMDKeyboard5 ='Clavier Nokia 1050 ou similaire';
  sLMDKeyboard6 ='Clavier Nokia 9140 ou similaire';
  sLMDKeyboard7 ='Clavier japonais';

  sLMDSysKeyboardPropTitleDelay = 'D�lai';
    sLMDSysKeyboardPropDescDelay = '';
  sLMDSysKeyboardPropTitleSpeed = 'Vitesse';
    sLMDSysKeyboardPropDescSpeed = '';
  sLMDSysKeyboardPropTitleNumLock = 'Verr num';
    sLMDSysKeyboardPropDescNumLock = '';
  sLMDSysKeyboardPropTitleCapsLock = 'Verr maj';
    sLMDSysKeyboardPropDescCapsLock = '';
  sLMDSysKeyboardPropTitleCaretBlinkTime = 'Fr�quence de clignotement du curseur';
    sLMDSysKeyboardPropDescCaretBlinkTime = '';
  sLMDSysKeyboardPropTitleScrollLock = 'Arr�t d�fil';
    sLMDSysKeyboardPropDescScrollLock = '';
  sLMDSysKeyboardPropTitleTypeString = 'Type de clavier';
    sLMDSysKeyboardPropDescTypeString = '';
  sLMDSysKeyboardPropTitleType = 'TypeID';
    sLMDSysKeyboardPropDescType = '';
  sLMDSysKeyboardPropTitleSubType = 'SubTypeID';
    sLMDSysKeyboardPropDescSubType = '';
  sLMDSysKeyboardPropTitleFunctionKeys = 'Touches de fonctions';
    sLMDSysKeyboardPropDescFunctionKeys = '';
  sLMDSysKeyboardPropTitleLayout = 'Disposition';
    sLMDSysKeyboardPropDescLayout = '';

  // MEMORY Display Strings
  // ----------------------
  sLMDSysMemoryObjectsTitle = 'M�moire';
    sLMDSysMemoryObjectsDesc = '';

  sLMDSysMemoryPropTitleMemoryLoad = 'MemoryLoad';
    sLMDSysMemoryPropDescMemoryLoad = '';
  sLMDSysMemoryPropTitleTotalPhysicalMemory = 'M�moire physique totale';
    sLMDSysMemoryPropDescTotalPhysicalMemory = '';
  sLMDSysMemoryPropTitleAvailablePhysicalMemory = 'M�moire physique disponible';
    sLMDSysMemoryPropDescAvailablePhysicalMemory = '';
  sLMDSysMemoryPropTitleTotalPageFile = 'TotalPageFile';
    sLMDSysMemoryPropDescTotalPageFile = '';
  sLMDSysMemoryPropTitleAvailablePageFile = 'AvailablePageFile';
    sLMDSysMemoryPropDescAvailablePageFile = '';
  sLMDSysMemoryPropTitleTotalVirtual = 'M�moire virtuelle totale';
    sLMDSysMemoryPropDescTotalVirtual = '';
  sLMDSysMemoryPropTitleAvailableVirtual = 'M�moire virtuelle disponible';
    sLMDSysMemoryPropDescAvailableVirtual = '';
  sLMDSysMemoryPropTitlePageSize = 'PageSize';
    sLMDSysMemoryPropDescPageSize = '';
  sLMDSysMemoryPropTitleAllocationGranularity = 'AllocationGranularity';
    sLMDSysMemoryPropDescAllocationGranularity = '';
  sLMDSysMemoryPropTitleMinAppAddress = 'MinAppAddress';
    sLMDSysMemoryPropDescMinAppAddress = '';
  sLMDSysMemoryPropTitleMaxAppAddress = 'MaxAppAddress';
    sLMDSysMemoryPropDescMaxAppAddress = '';
  sLMDSysMemoryPropTitleAvailableExtendedVirtual = 'AvailableExtendedVirtual';
    sLMDSysMemoryPropDescAvailableExtendedVirtual = '';

  // TLMDSysProcessorObject Display Strings
  // -------------------------------------
  sLMDSysProcessorObjectsTitle = 'Processeur';
    sLMDSysProcessorObjectsDesc = '';
  
  {$ifdef CLR}
  sLMDSysProcessorPropTitleAddressWidth = 'AddressWidth';
    sLMDSysProcessorPropDescAddressWidth = '';
  sLMDSysProcessorPropTitleArchitecture = 'Architecture';
    sLMDSysProcessorPropDescArchitecture = '';
  sLMDSysProcessorPropTitleAvailability = 'Availability';
    sLMDSysProcessorPropDescAvailability = '';
  sLMDSysProcessorPropTitleCpuStatus = 'CpuStatus';
    sLMDSysProcessorPropDescCpuStatus = '';
  sLMDSysProcessorPropTitleCurrentClockSpeed = 'CurrentClockSpeed';
    sLMDSysProcessorPropDescCurrentClockSpeed = '';
  sLMDSysProcessorPropTitleCurrentVoltage = 'CurrentVoltage';
    sLMDSysProcessorPropDescCurrentVoltage = '';
  sLMDSysProcessorPropTitleDataWidth = 'DataWidth';
    sLMDSysProcessorPropDescDataWidth = '';
  sLMDSysProcessorPropTitleDescription = 'Description';
    sLMDSysProcessorPropDescDescription = '';
  sLMDSysProcessorPropTitleDeviceID = 'DeviceID';
    sLMDSysProcessorPropDescDeviceID = '';
  sLMDSysProcessorPropTitleExtClock = 'ExtClock';
    sLMDSysProcessorPropDescExtClock = '';
  sLMDSysProcessorPropTitleFamily = 'Family';
    sLMDSysProcessorPropDescFamily = '';
  sLMDSysProcessorPropTitleL2CacheSize = 'L2CacheSize';
    sLMDSysProcessorPropDescL2CacheSize = '';
  sLMDSysProcessorPropTitleL2CacheSpeed = 'L2CacheSpeed';
    sLMDSysProcessorPropDescL2CacheSpeed = '';
  sLMDSysProcessorPropTitleLastErrorCode = 'LastErrorCode';
    sLMDSysProcessorPropDescLastErrorCode = '';
  sLMDSysProcessorPropTitleLevel = 'Level';
    sLMDSysProcessorPropDescLevel = '';
  sLMDSysProcessorPropTitleLoadPercentage = 'LoadPercentage';
    sLMDSysProcessorPropDescLoadPercentage = '';
  sLMDSysProcessorPropTitleManufacturer = 'Manufacturer';
    sLMDSysProcessorPropDescManufacturer = '';
  sLMDSysProcessorPropTitleMaxClockSpeed = 'MaxClockSpeed';
    sLMDSysProcessorPropDescMaxClockSpeed = '';
  sLMDSysProcessorPropTitleName = 'Name';
    sLMDSysProcessorPropDescName = '';
  sLMDSysProcessorPropTitleOtherFamilyDescription = 'OtherFamilyDescription';
    sLMDSysProcessorPropDescOtherFamilyDescription = '';
  sLMDSysProcessorPropTitleProcessorId = 'ProcessorId';
    sLMDSysProcessorPropDescProcessorId = '';
  sLMDSysProcessorPropTitleProcessorType = 'ProcessorType';
    sLMDSysProcessorPropDescProcessorType = '';
  sLMDSysProcessorPropTitleRevision = 'Revision';
    sLMDSysProcessorPropDescRevision = '';
  sLMDSysProcessorPropTitleRole = 'Role';
    sLMDSysProcessorPropDescRole = '';
  sLMDSysProcessorPropTitleSocketDesignation = 'SocketDesignation';
    sLMDSysProcessorPropDescSocketDesignation = '';
  sLMDSysProcessorPropTitleStatus = 'Status';
    sLMDSysProcessorPropDescStatus = '';
  sLMDSysProcessorPropTitleStatusInfo = 'StatusInfo';
    sLMDSysProcessorPropDescStatusInfo = '';
  sLMDSysProcessorPropTitleStepping = 'Stepping';
    sLMDSysProcessorPropDescStepping = '';
  sLMDSysProcessorPropTitleSystemName = 'SystemName';
    sLMDSysProcessorPropDescSystemName = '';
  sLMDSysProcessorPropTitleUniqueId = 'UniqueId';
    sLMDSysProcessorPropDescUniqueId = '';
  sLMDSysProcessorPropTitleUpgradeMethod = 'UpgradeMethod';
    sLMDSysProcessorPropDescUpgradeMethod = '';
  sLMDSysProcessorPropTitleVoltageCaps = 'VoltageCaps';
    sLMDSysProcessorPropDescVoltageCaps = '';
  {$else}
  sLMDSysProcessorPropTitleProcessorUsage = 'Usage processeur';
    sLMDSysProcessorPropDescProcessorUsage = '';
  sLMDSysProcessorPropTitleIDString = 'IDString';
    sLMDSysProcessorPropDescIDString = '';
  sLMDSysProcessorPropTitleCPUName = 'Nom du processeur';
    sLMDSysProcessorPropDescCPUName = '';
  sLMDSysProcessorPropTitleCount = 'Count';
    sLMDSysProcessorPropDescCount = '';
  sLMDSysProcessorPropTitleStepping = 'Stepping';
    sLMDSysProcessorPropDescStepping = '';
  sLMDSysProcessorPropTitleModel = 'Model';
    sLMDSysProcessorPropDescModel = '';
  sLMDSysProcessorPropTitleFamily = 'Family';
    sLMDSysProcessorPropDescFamily = '';
  sLMDSysProcessorPropTitleFPU = 'FPU';
    sLMDSysProcessorPropDescFPU = '';
  sLMDSysProcessorPropTitleVirtualModeExtensions = 'VirtualModeExtensions';
    sLMDSysProcessorPropDescVirtualModeExtensions = '';
  sLMDSysProcessorPropTitleDebuggingExtensions = 'DebuggingExtensions';
    sLMDSysProcessorPropDescDebuggingExtensions = '';
  sLMDSysProcessorPropTitlePageSizeExtensions = 'PageSizeExtensions';
    sLMDSysProcessorPropDescPageSizeExtensions = '';
  sLMDSysProcessorPropTitleTimeStampCounter = 'TimeStampCounter';
    sLMDSysProcessorPropDescTimeStampCounter = '';
  sLMDSysProcessorPropTitleK86_ModelSpecificRegisters = 'K86_ModelSpecificRegisters';
    sLMDSysProcessorPropDescK86_ModelSpecificRegisters = '';
  sLMDSysProcessorPropTitleMachineCheckException = 'MachineCheckException';
    sLMDSysProcessorPropDescMachineCheckException = '';
  sLMDSysProcessorPropTitleCMP_XCHG_8B = 'CMP_XCHG_8B';
    sLMDSysProcessorPropDescCMP_XCHG_8B = '';
  sLMDSysProcessorPropTitleAPIC = 'APIC';
    sLMDSysProcessorPropDescAPIC = '';
  sLMDSysProcessorPropTitleMemoryTypeRangeRegisters = 'MemoryTypeRangeRegisters';
    sLMDSysProcessorPropDescMemoryTypeRangeRegisters = '';
  sLMDSysProcessorPropTitleGlobalPaging = 'GlobalPaging';
    sLMDSysProcessorPropDescGlobalPaging = '';
  sLMDSysProcessorPropTitleCond_MOVE_Instruct = 'Cond_MOVE_Instruct';
    sLMDSysProcessorPropDescCond_MOVE_Instruct = '';
  sLMDSysProcessorPropTitleMMX = 'MMX';
    sLMDSysProcessorPropDescMMX = '';
  sLMDSysProcessorPropTitleSYSCALLandSYSRET = 'SYSCALLandSYSRET';
    sLMDSysProcessorPropDescSYSCALLandSYSRET = '';
  sLMDSysProcessorPropTitleFPCond_MOVE_Instruct = 'FPCond_MOVE_Instruct';
    sLMDSysProcessorPropDescFPCond_MOVE_Instruct = '';
  sLMDSysProcessorPropTitleAMD3DNow = 'AMD3DNow';
    sLMDSysProcessorPropDescAMD3DNow = '';
  sLMDSysProcessorPropTitleIdentifier = 'Identifier';
    sLMDSysProcessorPropDescIdentifier = '';
  sLMDSysProcessorPropTitleVendorIdentifier = 'VendorIdentifier';
    sLMDSysProcessorPropDescVendorIdentifier = '';
  sLMDSysProcessorPropTitleMHz = 'MHz';
    sLMDSysProcessorPropDescMHz = '';
  {$endif}

  // POWER STATUS Display Strings
  // -----------------------------
  sLMDSysPowerStatusObjectsTitle = 'Gestion de l''alimentation';
    sLMDSysPowerStatusObjectsDesc = '';

  sLMDSysPowerStatusPropTitleACLineStatus = 'ACLineStatus';
    sLMDSysPowerStatusPropDescACLineStatus = '';
  sLMDSysPowerStatusPropTitleBatteryFlags = 'BatteryFlags';
    sLMDSysPowerStatusPropDescBatteryFlags = '';
  sLMDSysPowerStatusPropTitleBatteryLifePercent = 'Pourcentage restant de la batterie';
    sLMDSysPowerStatusPropDescBatteryLifePercent = '';
  sLMDSysPowerStatusPropTitleBatteryLifeTime = 'Dur�e de la batterie';
    sLMDSysPowerStatusPropDescBatteryLifeTime = '';
  sLMDSysPowerStatusPropTitleBatteryFullLifeTime = 'Dur�e totale de la batterie';
    sLMDSysPowerStatusPropDescBatteryFullLifeTime = '';
  sACLineStatusOffline = 'Offline';
  sACLineStatusOnline = 'Online';
  sACLineStatusUnknown = 'Inconnu';
  sBatteryFlagHigh = 'Haut';
  sBatteryFlagLow = 'Faible';
  sBatteryFlagCritical = 'Critique';
  sBatteryFlagCharging = 'En charge';
  sBatteryFlagNoSystemBat = 'Pas de batterie';
  sBatteryFlagUnkown = 'Inconnu';

  // TLMDSysTimeZoneObject Display Strings
  // -------------------------------------
  sLMDSysTimeZoneObjectsTitle = 'Time Zone';
    sLMDSysTimeZoneStatusObjectsDesc = '';
  sLMDSysTimeZoneStart=' (Start)';
  sLMDSysTimeZoneStandard='Standard';
  sLMDSysTimeZoneDayLight='Daylight';

  sLMDSysTimeZonePropTitleTimeZoneID = 'Timezone ID';
    sLMDSysTimeZonePropDescTimezoneID = '';

  sLMDSysTimeZonePropTitleBias = 'Bias';
    sLMDSysTimeZonePropDescBias = '';
  sLMDSysTimeZonePropTitleDayLightBias = 'DayLightBias';
    sLMDSysTimeZonePropDescDayLightBias = '';
  sLMDSysTimeZonePropTitleStandardBias = 'StandardBias';
    sLMDSysTimeZonePropDescStandardBias = '';
  sLMDSysTimeZonePropTitleDayLightName = 'DayLightName';
    sLMDSysTimeZonePropDescDayLightName = '';
  sLMDSysTimeZonePropTitleStandardName = 'StandardName';
    sLMDSysTimeZonePropDescStandardName = '';
  sLMDSysTimeZonePropTitleDayLightDate = 'DayLightStartDate';
    sLMDSysTimeZonePropDescDayLightDate = '';
  sLMDSysTimeZonePropTitleStandardDate = 'StandardStartDate';
    sLMDSysTimeZonePropDescStandardDate = '';

  // LOCALE Display Strings
  // ----------------------
  sLMDSysLocaleObjectsTitle = 'Options r�gionales';
    sLMDSysLocaleObjectsDesc = '';

  sLMDSysLocalePropTitleCalendarType = 'Calendrier';
    sLMDSysLocalePropDescCalendarType = '';
  sLMDSysLocalePropTitleCurrencyDigits = 'Nombre de d�cimales';
    sLMDSysLocalePropDescCurrencyDigits = '';
  sLMDSysLocalePropTitlePositiveCurrencyFormat = 'Format de nombre positif';
    sLMDSysLocalePropDescPositiveCurrencyFormat = '';
  sLMDSysLocalePropTitleDigits = 'Nombre de d�cimales';
    sLMDSysLocalePropDescDigits = '';
  sLMDSysLocalePropTitleFirstDayOfWeek = 'Premier jour de la semaine';
    sLMDSysLocalePropDescFirstDayOfWeek = '';
  sLMDSysLocalePropTitleFirstWeekOfYear = 'Premi�re semaine de l''ann�e';
    sLMDSysLocalePropDescFirstWeekOfYear = '';
  sLMDSysLocalePropTitleShowLeadingZero = 'Afficher les z�ros en en-t�te';
    sLMDSysLocalePropDescShowLeadingZero = '';
  sLMDSysLocalePropTitleMeasurement = 'Syst�me de mesure';
    sLMDSysLocalePropDescMeasurement = '';
  sLMDSysLocalePropTitleNegativeCurrencyFormat = 'Format de nombre n�gatif';
    sLMDSysLocalePropDescNegativeCurrencyFormat = '';
  sLMDSysLocalePropTitleNegativeFormat = 'Format de nombre n�gatif';
    sLMDSysLocalePropDescNegativeFormat = '';
  sLMDSysLocalePropTitleClockMode = 'Format de l''heure';
    sLMDSysLocalePropDescClockMode = '';
  sLMDSysLocalePropTitleMorningSymbol = 'Symbole AM';
    sLMDSysLocalePropDescMorningSymbol = '';
  sLMDSysLocalePropTitleAfternoonSymbol = 'Symbole PM';
    sLMDSysLocalePropDescAfternoonSymbol = '';
  sLMDSysLocalePropTitleCurrencySymbol = 'Symbole mon�taire';
    sLMDSysLocalePropDescCurrencySymbol = '';
  sLMDSysLocalePropTitleDateSeparator = 'S�parateur de date';
    sLMDSysLocalePropDescDateSeparator = '';
  sLMDSysLocalePropTitleDecimalSeparator = 'S�parateur d�cimal';
    sLMDSysLocalePropDescDecimalSeparator = '';
  sLMDSysLocalePropTitleGrouping = 'Groupement des chiffres';
    sLMDSysLocalePropDescGrouping = '';
  sLMDSysLocalePropTitleListSeparator = 'S�parateur de listes';
    sLMDSysLocalePropDescListSeparator = '';
  sLMDSysLocalePropTitleLongDateFormat = 'Format de date longue';
    sLMDSysLocalePropDescLongDateFormat = '';
  sLMDSysLocalePropTitleCurrencyDecimalSeparator = 'S�parateur d�cimal';
    sLMDSysLocalePropDescCurrencyDecimalSeparator = '';
  sLMDSysLocalePropTitleCurrencyGrouping = 'Groupement des chiffres';
    sLMDSysLocalePropDescCurrencyGrouping = '';
  sLMDSysLocalePropTitleCurrencyGroupingSign = 'S�parateur de milliers';
    sLMDSysLocalePropDescCurrencyGroupingSign = '';
  sLMDSysLocalePropTitleNegativeSign = 'Symbole du signe n�gatif';
    sLMDSysLocalePropDescNegativeSign = '';
  sLMDSysLocalePropTitlePositiveSign = 'Symbole du signe positif';
    sLMDSysLocalePropDescPositiveSign = '';
  sLMDSysLocalePropTitleShortDateFormat = 'Format de date courte';
    sLMDSysLocalePropDescShortDateFormat = '';
  sLMDSysLocalePropTitleThousandSeparator = 'S�parateur de milliers';
    sLMDSysLocalePropDescThousandSeparator = '';
  sLMDSysLocalePropTitleTimeSeparator = 'S�parateur horaire';
    sLMDSysLocalePropDescTimeSeparator = '';
  sLMDSysLocalePropTitleTimeFormat = 'Format de l''heure';
    sLMDSysLocalePropDescTimeFormat = '';
  sLMDSysLocalePropTitleShortDateOrder = 'Ordre date courte';
    sLMDSysLocalePropDescShortDateOrder = '';
  sLMDSysLocalePropTitleLongDateOrder = 'Ordre date longue';
    sLMDSysLocalePropDescLongDateOrder = '';
  sLMDSysLocalePropTitleYearDigits = 'Nombre de chiffres pour l''ann�e';
    sLMDSysLocalePropDescYearDigits = '';
  sLMDSysLocalePropTitleInternationalCurrencySymbol = 'Symbole mon�taire international';
    sLMDSysLocalePropDescInternationalCurrencySymbol = '';
  sLMDSysLocalePropTitleLanguage = 'Langue';
    sLMDSysLocalePropDescLanguage = '';
  sLMDSysLocalePropTitleLanguageEnglish = 'Langue anglaise';
    sLMDSysLocalePropDescLanguageEnglish = '';
  sLMDSysLocalePropTitleLanguageSymbol = 'Symbole de langue';
    sLMDSysLocalePropDescLanguageSymbol = '';
  sLMDSysLocalePropTitleCountryCode = 'Code du pays';
    sLMDSysLocalePropDescCountryCode = '';
  sLMDSysLocalePropTitleCountry = 'Pays';
    sLMDSysLocalePropDescCountry = '';
  sLMDSysLocalePropTitleCountrySymbol = 'Symbole du pays';
    sLMDSysLocalePropDescCountrySymbol = '';

  // UNINSTALL SECTION
  sLMDSysUninstallGroupTitle = 'D�sinstallation';
    sLMDSysUninstallGroupDesc = '';

  sLMDSysUninstallPropTitleProgramName = 'Nom du programme';
    sLMDSysUninstallPropDescProgramName = '';
  sLMDSysUninstallPropTitleUninstallPath = 'Chemin d�sinstallation';
    sLMDSysUninstallPropDescUninstallPath = '';
  sLMDSysUninstallPropTitlePublisher = 'Editeur';
    sLMDSysUninstallPropDescPublisher = '';
  sLMDSysUninstallPropTitlePublisherURL = 'Site de l''�diteur';
    sLMDSysUninstallPropDescPublisherURL = '';
  sLMDSysUninstallPropTitleVersion = 'Version';
    sLMDSysUninstallPropDescVersion = '';
  sLMDSysUninstallPropTitleHelpLink = 'Aide';
    sLMDSysUninstallPropDescHelpLink = '';
  sLMDSysUninstallPropTitleUpdateInfoURL = 'UpdateInfoURL';
    sLMDSysUninstallPropDescUpdateInfoURL = '';
  sLMDSysUninstallPropTitleRegCompany = 'Entreprise';
    sLMDSysUninstallPropDescRegCompany = '';
  sLMDSysUninstallPropTitleRegOwner = 'Propri�taire';
    sLMDSysUninstallPropDescRegOwner = '';

  // FONTS SECTION    
  sLMDSysFontGroupTitle = 'Polices';
    sLMDSysFontGroupDesc = '';

  sLMDSysFontPropTitleFontType = 'Type';
    sLMDSysFontPropDescFontType = '';
  sLMDSysFontPropTitleFullName = 'Nom complet';
    sLMDSysFontPropDescFullName = '';
  sLMDSysFontPropTitleStyle = 'Style';
    sLMDSysFontPropDescStyle = '';
  sLMDSysFontPropTitleScript = 'Script';
    sLMDSysFontPropDescScript = '';
  sLMDSysFontPropTitleLogHeight = 'LogHeight';
    sLMDSysFontPropDescLogHeight = '';
  sLMDSysFontPropTitleLogWidth = 'LogWidth';
    sLMDSysFontPropDescLogWidth = '';
  sLMDSysFontPropTitleLogEscapement = 'Escapement';
    sLMDSysFontPropDescLogEscapement = '';
  sLMDSysFontPropTitleLogOrientation = 'LogOrientation';
    sLMDSysFontPropDescLogOrientation = '';
  sLMDSysFontPropTitleLogWeight = 'LogWeight';
    sLMDSysFontPropDescLogWeight = '';
  sLMDSysFontPropTitleLogItalic = 'LogItalic';
    sLMDSysFontPropDescLogItalic = '';
  sLMDSysFontPropTitleLogUnderline = 'LogUnderline';
    sLMDSysFontPropDescLogUnderline = '';
  sLMDSysFontPropTitleLogStikeOut = 'LogStikeOut';
    sLMDSysFontPropDescLogStikeOut = '';
  sLMDSysFontPropTitleLogCharSet = 'LogCharSet';
    sLMDSysFontPropDescLogCharSet = '';
  sLMDSysFontPropTitleLogOutPrecision = 'LogOutPrecision';
    sLMDSysFontPropDescLogOutPrecision = '';
  sLMDSysFontPropTitleLogClipPrecision = 'LogClipPrecision';
    sLMDSysFontPropDescLogClipPrecision = '';
  sLMDSysFontPropTitleLogQuality = 'LogQuality';
    sLMDSysFontPropDescLogQuality = '';
  sLMDSysFontPropTitleLogPitch = 'LogPitch';
    sLMDSysFontPropDescLogPitch = '';
  sLMDSysFontPropTitleLogFamily = 'LogFamily';
    sLMDSysFontPropDescLogFamily = '';
  sLMDSysFontPropTitleLogFaceName = 'LogFaceName';
    sLMDSysFontPropDescLogFaceName = '';
  sLMDSysFontPropTitletmHeight = 'tmHeight';
    sLMDSysFontPropDesctmHeight = '';
  sLMDSysFontPropTitletmAscent = 'tmAscent';
    sLMDSysFontPropDesctmAscent = '';
  sLMDSysFontPropTitletmDescent = 'tmDescent';
    sLMDSysFontPropDesctmDescent = '';
  sLMDSysFontPropTitletmInternalLeading = 'tmInternalLeading';
    sLMDSysFontPropDesctmInternalLeading = '';
  sLMDSysFontPropTitletmExternalLeading = 'tmExternalLeading';
    sLMDSysFontPropDesctmExternalLeading = '';
  sLMDSysFontPropTitletmAveCharWidth = 'tmAveCharWidth';
    sLMDSysFontPropDesctmAveCharWidth = '';
  sLMDSysFontPropTitletmMaxCharWidth = 'tmMaxCharWidth';
    sLMDSysFontPropDesctmMaxCharWidth = '';
  sLMDSysFontPropTitletmWeight = 'tmWeight';
    sLMDSysFontPropDesctmWeight = '';
  sLMDSysFontPropTitletmOverhang = 'tmOverhang';
    sLMDSysFontPropDesctmOverhang = '';
  sLMDSysFontPropTitletmDigitizedAspectX = 'tmDigitizedAspectX';
    sLMDSysFontPropDesctmDigitizedAspectX = '';
  sLMDSysFontPropTitletmDigitizedAspectY = 'tmDigitizedAspectY';
    sLMDSysFontPropDesctmDigitizedAspectY = '';
  sLMDSysFontPropTitletmFirstChar = 'tmFirstChar';
    sLMDSysFontPropDesctmFirstChar = '';
  sLMDSysFontPropTitletmLastChar = 'tmLastChar';
    sLMDSysFontPropDesctmLastChar = '';
  sLMDSysFontPropTitletmDefaultChar = 'tmDefaultChar';
    sLMDSysFontPropDesctmDefaultChar = '';
  sLMDSysFontPropTitletmBreakChar = 'tmBreakChar';
    sLMDSysFontPropDesctmBreakChar = '';
  sLMDSysFontPropTitletmItalic = 'tmItalic';
    sLMDSysFontPropDesctmItalic = '';
  sLMDSysFontPropTitletmUnderline = 'tmUnderline';
    sLMDSysFontPropDesctmUnderline = '';
  sLMDSysFontPropTitletmStikeOut = 'tmStikeOut';
    sLMDSysFontPropDesctmStikeOut = '';
  sLMDSysFontPropTitletmPitch = 'tmPitch';
    sLMDSysFontPropDesctmPitch = '';
  sLMDSysFontPropTitletmFamily = 'tmFamily';
    sLMDSysFontPropDesctmFamily = '';
  sLMDSysFontPropTitletmCharSet = 'tmCharSet';
    sLMDSysFontPropDesctmCharSet = '';
  sLMDSysFontPropTitletmFlags = 'tmFlags';
    sLMDSysFontPropDesctmFlags = '';
  sLMDSysFontPropTitletmSizeEM = 'tmSizeEM';
    sLMDSysFontPropDesctmSizeEM = '';
  sLMDSysFontPropTitletmCellHeight = 'tmCellHeight';
    sLMDSysFontPropDesctmCellHeight = '';
  sLMDSysFontPropTitletmAvgWidth = 'tmAvgWidth';
    sLMDSysFontPropDesctmAvgWidth = '';

  sFontTypeDEVICE = 'DEVICE';
  sFontTypeRASTER = 'RASTER';
  sFontTypeTRUETYPE = 'TRUETYPE';

  sCharSetANSI_CHARSET	= 'Caract�res ANSI';
  sCharSetDEFAULT_CHARSET = 'La police est choisie selon le nom et la taille. Si la police n''est pas disponible, Windows la remplacera par une autre.';
  sCharSetSYMBOL_CHARSET =  'Symboles standard';
  sCharSetMAC_CHARSET = 'Caract�res Macintosh. Non disponible sur NT 3.51';
  sCharSetSHIFTJIS_CHARSET = 'Caract�res japonnais shift-jis';
  sCharSetHANGEUL_CHARSET = 'Caract�res cor�ens (Wansung)';
  sCharSetJOHAB_CHARSET = 'Caract�res cor�ens (Johab). Non disponible sur NT 3.51';
  sCharSetGB2312_CHARSET = 'Caract�res simplifi�s chinois (mainland china)';
  sCharSetCHINESEBIG5_CHARSET = 'Caract�res traditionnels chinois (taiwanese)';
  sCharSetGREEK_CHARSET = 'Caract�res grecs. Non disponible sur NT 3.51';
  sCharSetTURKISH_CHARSET = 'Caract�res turcs. Non disponible sur NT 3.51';
  sCharSetVIETNAMESE_CHARSET = 'Caract�res vietnamiens. Non disponible sur NT 3.51';
  sCharSetHEBREW_CHARSET = 'Caract�res h�breus. Non disponible sur NT 3.51';
  sCharSetARABIC_CHARSET = 'Caract�res arabes. Non disponible sur NT 3.51';
  sCharSetBALTIC_CHARSET = 'Caract�res baltes. Non disponible sur NT 3.51';
  sCharSetRUSSIAN_CHARSET = 'Caract�res cyrillique. Non disponible sur NT 3.51';
  sCharSetTHAI_CHARSET = 'Caract�res thai. Non disponible sur NT 3.51';
  sCharSetEASTEUROPE_CHARSET = 'Inclus des symboles pour les pays d''Europe de l''est. Non disponible sur NT 3.51';
  sCharSetOEM_CHARSET = 'D�pend de la page de code du syst�me d''exploitation';

  sFontPitchDefault = 'D�faut';
  sFontPitchVariable = 'Variable';
  sFontPitchFixed = 'Fixe';

  sTM_ITALIC = 'ITALIQUE';
  sTM_BOLD = 'GRAS';
  sTM_REGULAR = 'REGULAR';
  sTM_NONNEGATIVE_AC = 'NONNEGATIVE_AC';
  sTM_PS_OPENTYPE = 'PS_OPENTYPE';
  sTM_TT_OPENTYPE = 'TT_OPENTYPE';
  sTM_MULTIPLEMASTER = 'MULTIPLEMASTER';
  sTM_TYPE1 = 'TYPE1';
  sTM_DSIG = 'DSIG';

  // MULTIMEDIA SECTION
  sLMDSysMultimediaGroupTitle = 'Multim�dia';
    sLMDSysMultimediaGroupDesc = '';
  sLMDSysJoystickGroupTitle = 'Joystick';
    sLMDSysJoystickGroupDesc = '';
  sLMDSysmidiOutAudioGroupTitle = 'Midi Out';
    sLMDSysmidiOutAudioGroupDesc = '';
  sLMDSysmidiInAudioGroupTitle = 'Midi In';
    sLMDSysmidiInAudioGroupDesc = '';
  sLMDSyswaveOutAudioGroupTitle = 'Wave Out';
    sLMDSyswaveOutAudioGroupDesc = '';
  sLMDSyswaveInAudioGroupTitle = 'Wave In';
    sLMDSyswaveInAudioGroupDesc = '';
  sLMDSysDauxAudioGroupTitle = 'DAUX';
    sLMDSysDauxAudioGroupDesc = '';
  sLMDSysMixerGroupTitle = 'Mixer';
    sLMDSysMixerGroupDesc = '';


  sLMDSysMultimediaCmnPropTitleDeviceID = 'Id p�riph�rique';
    sLMDSysMultimediaCmnPropDescDeviceID = '';
  sLMDSysMultimediaCmnPropTitleManufacturerID = 'Fabricant du p�riph�rique';
    sLMDSysMultimediaCmnPropDescManufacturerID = '';
  sLMDSysMultimediaCmnPropTitleProductID = 'Id produit';
    sLMDSysMultimediaCmnPropDescProductID = '';
  sLMDSysMultimediaCmnPropTitleMajorVer = 'Version majeure';
    sLMDSysMultimediaCmnPropDescMajorVer = '';
  sLMDSysMultimediaCmnPropTitleMinorVer = 'Version mineur';
    sLMDSysMultimediaCmnPropDescMinorVer = '';
  sLMDSysMultimediaCmnPropTitleName = 'Nom';
    sLMDSysMultimediaCmnPropDescName = '';

  sLMDSysJoystickPropTitleXmin = 'Xmin';
    sLMDSysJoystickPropDescXmin = '';
  sLMDSysJoystickPropTitleXmax = 'Xmax';
    sLMDSysJoystickPropDescXmax = '';
  sLMDSysJoystickPropTitleYmin = 'Ymin';
    sLMDSysJoystickPropDescYmin = '';
  sLMDSysJoystickPropTitleYmax = 'Ymax';
    sLMDSysJoystickPropDescYmax = '';
  sLMDSysJoystickPropTitleZmin = 'Zmin';
    sLMDSysJoystickPropDescZmin = '';
  sLMDSysJoystickPropTitleZmax = 'Zmax';
    sLMDSysJoystickPropDescZmax = '';
  sLMDSysJoystickPropTitleNumButtons = 'NumButtons';
    sLMDSysJoystickPropDescNumButtons = '';
  sLMDSysJoystickPropTitlePeriodMin = 'PeriodMin';
    sLMDSysJoystickPropDescPeriodMin = '';
  sLMDSysJoystickPropTitlePeriodMax = 'PeriodMax';
    sLMDSysJoystickPropDescPeriodMax = '';
  sLMDSysJoystickPropTitleRmin = 'Rmin';
    sLMDSysJoystickPropDescRmin = '';
  sLMDSysJoystickPropTitleRmax = 'Rmax';
    sLMDSysJoystickPropDescRmax = '';
  sLMDSysJoystickPropTitleUmin = 'Umin';
    sLMDSysJoystickPropDescUmin = '';
  sLMDSysJoystickPropTitleUmax = 'Umax';
    sLMDSysJoystickPropDescUmax = '';
  sLMDSysJoystickPropTitleVmin = 'Vmin';
    sLMDSysJoystickPropDescVmin = '';
  sLMDSysJoystickPropTitleVmax = 'Vmax';
    sLMDSysJoystickPropDescVmax = '';
  sLMDSysJoystickPropTitleCaps = 'Caps';
    sLMDSysJoystickPropDescCaps = '';
  sLMDSysJoystickPropTitleMaxAxes = 'MaxAxes';
    sLMDSysJoystickPropDescMaxAxes = '';
  sLMDSysJoystickPropTitleNumAxes = 'NumAxes';
    sLMDSysJoystickPropDescNumAxes = '';
  sLMDSysJoystickPropTitleMaxButtons = 'MaxButtons';
    sLMDSysJoystickPropDescMaxButtons = '';
  sLMDSysJoystickPropTitleRegKey = 'RegKey';
    sLMDSysJoystickPropDescRegKey = '';
  sLMDSysJoystickPropTitleOEMVxD = 'OEMVxD';
    sLMDSysJoystickPropDescOEMVxD = '';

  sJoyCapHASZ = 'HASZ';
  sJoyCapHASR = 'HASR';
  sJoyCapHASU = 'HASU';
  sJoyCapHASV = 'HASV';
  sJoyCapHASPOV = 'HASPOV';
  sJoyCapPOV4DIR = 'POV4DIR';
  sJoyCapPOVCTS = 'POVCTS';

  sLMDSysmidiOutAudioPropTitleTechnology = 'Technologie';
    sLMDSysmidiOutAudioPropDescTechnology = '';
  sLMDSysmidiOutAudioPropTitleVoices = 'Voix';
    sLMDSysmidiOutAudioPropDescVoices = '';
  sLMDSysmidiOutAudioPropTitleNotes = 'Notes';
    sLMDSysmidiOutAudioPropDescNotes = '';
  sLMDSysmidiOutAudioPropTitleChannelMask = 'ChannelMask';
    sLMDSysmidiOutAudioPropDescChannelMask = '';
  sLMDSysmidiOutAudioPropTitleSupport = 'Support';
    sLMDSysmidiOutAudioPropDescSupport = '';

  sLMDMIDITechnologyMIDIPORT = 'Le p�riph�rique est un port MIDI mat�riel';
  sLMDMIDITechnologySYNTH = 'Le p�riph�rique est un synth�tizeur';
  sLMDMIDITechnologySQSYNTH = 'Le p�riph�rique est un synth�tizeur Wave';
  sLMDMIDITechnologyFMSYNTH = 'Le p�riph�rique est un synth�tizeur FM';
  sLMDMIDITechnologyMAPPER = 'Le p�riph�rique est le Microsoft MIDI mapper';
  sLMDMIDITechnologyWAVETABLE = 'Le p�riph�rique est un synth�tizeur table d''ondes mat�riel';
  sLMDMIDITechnologySWSYNTH = 'Le p�riph�rique est un synth�tizeur logiciel';

  sLMDMIDIChannel0 = 'ch0';
  sLMDMIDIChannel1 = 'ch1';
  sLMDMIDIChannel2 = 'ch2';
  sLMDMIDIChannel3 = 'ch3';
  sLMDMIDIChannel4 = 'ch4';
  sLMDMIDIChannel5 = 'ch5';
  sLMDMIDIChannel6 = 'ch6';
  sLMDMIDIChannel7 = 'ch7';
  sLMDMIDIChannel8 = 'ch8';
  sLMDMIDIChannel9 = 'ch9';
  sLMDMIDIChannel10 = 'ch10';
  sLMDMIDIChannel11 = 'ch11';
  sLMDMIDIChannel12 = 'ch12';
  sLMDMIDIChannel13 = 'ch13';
  sLMDMIDIChannel14 = 'ch14';
  sLMDMIDIChannel15 = 'ch15';

  sLMDMIDIOutSupportCACHE = 'CACHE';
  sLMDMIDIOutSupportLRVOLUME = 'GDVOLUME';
  sLMDMIDIOutSupportSTREAM = 'STREAM';
  sLMDMIDIOutSupportVOLUME = 'VOLUME';

  sLMDSyswaveOutAudioPropTitlewaweFormats = 'Formats';
    sLMDSyswaveOutAudioPropDescwaweFormats = '';
  sLMDSyswaveOutAudioPropTitlewaweChannels = 'Channels';
    sLMDSyswaveOutAudioPropDescwaweChannels = '';
  sLMDSyswaveOutAudioPropTitlewaweSupport = 'Support';
    sLMDSyswaveOutAudioPropDescwaweSupport = '';

  sLMDWaveFormat1M08 = '1M08';
  sLMDWaveFormat1M16 = '1M16';
  sLMDWaveFormat1S08 = '1S08';
  sLMDWaveFormat1S16 = '1S16';
  sLMDWaveFormat2M08 = '2M08';
  sLMDWaveFormat2M16 = '2M16';
  sLMDWaveFormat2S08 = '2S08';
  sLMDWaveFormat2S16 = '2S16';
  sLMDWaveFormat4M08 = '4M08';
  sLMDWaveFormat4M16 = '4M16';
  sLMDWaveFormat4S08 = '4S08';
  sLMDWaveFormat4S16 = '4S16';

  sLMDWaveOutSupportLRVOLUME = 'GDVOLUME';
  sLMDWaveOutSupportVOLUME = 'VOLUME';
  sLMDWaveOutSupportPITCH = 'PITCH';
  sLMDWaveOutSupportPLAYBACKRATE = 'PLAYBACKRATE';
  sLMDWaveOutSupportSYNC = 'SYNC';
  sLMDWaveOutSupportSAMPLEACCURATE = 'SAMPLEACCURATE';


  sLMDSysVolumPropTitleVolumeL = 'VolumeG';
    sLMDSysVolumPropDescVolumeL = '';
  sLMDSysVolumPropTitleVolumeR = 'VolumeD';
    sLMDSysVolumPropDescVolumeR = '';
  sLMDSysDauxAudioPropTitledauxTechnology = 'dauxTechnology';
    sLMDSysDauxAudioPropDescdauxTechnology = '';
  sLMDSysDauxAudioPropTitledauxSupport = 'dauxSupport';
    sLMDSysDauxAudioPropDescdauxSupport = '';

  sLMDDauxSupportNone = 'Aucun';
  sLMDDauxSupportVolume = 'Volume';
  sLMDDauxSupportLRVolume = 'GDVolume';

  sLMDDauxTechNone = 'Aucun';
  sLMDDauxTechAUXIN = 'AUXIN';
  sLMDDauxTechCDAUDIO = 'CDAUDIO';

  sLMDSysMixerPropTitleDestinations = 'Destinations';
    sLMDSysMixerPropDescDestinations = '';

  // File assoc section
  sLMDSysFileActionTitle = 'Action';
    sLMDSysFileActionDesc = '';
  sLMDSysFileActionGroupTitle = 'Actions';
    sLMDSysFileActionGroupDesc = '';
  sLMDSysFileAssocTitle = 'Association';
    sLMDSysFileAssocDesc = '';
  sLMDSysFileAssocGroupTitle = 'Associations';
    sLMDSysFileAssocGroupDesc = '';

  sLMDSysFileActionPropTitleActionName = 'ActionName';
    sLMDSysFileActionPropDescActionName = '';
  sLMDSysFileActionPropTitleActionFile = 'ActionFile';
    sLMDSysFileActionPropDescActionFile = '';

  sLMDSysFileAssocPropTitleassocExt = 'Ext';
    sLMDSysFileAssocPropDescassocExt = '';
  sLMDSysFileAssocPropTitleassocDescription = 'Description';
    sLMDSysFileAssocPropDescassocDescription = '';
  sLMDSysFileAssocPropTitleassocDefaultIconStr = 'DefaultIconStr';
    sLMDSysFileAssocPropDescassocDefaultIconStr = '';


  // INTERNET SECTION
  sLMDSysInetPropTitleBrowser='Navigateur';
    sLMDSysInetPropDescBrowser='';
  sLMDSysInetAdvPropGroupTitle = 'Propri�t�s avanc�es';
    sLMDSysInetAdvPropGroupDesc = '';
  sLMDSysInetAdvPropTitle = 'Propri�t� avanc�e';
    sLMDSysInetAdvPropDesc = '';
  sLMDSysInetZoneGroupTitle = 'Internet Zones';
    sLMDSysInetZoneGroupDesc = '';
  sLMDSysInetZoneTitle = 'Internet Zone';
    sLMDSysInetZoneDesc = '';
//  sLMDSysTempInternetFilesTitle = 'Temp Internet Files';
//    sLMDSysTempInternetFilesDesc = '';
  sLMDSysInternetTitle = 'Internet';
    sLMDSysInternetDesc = '';

  sLMDSysInetPropTitleName = 'Nom';
    sLMDSysInetPropDescName = '';
  sLMDSysInetPropTitleValue = 'Valeur';
    sLMDSysInetPropDescValue = '';
  sLMDSysInetPropTitleZoneName = 'Nom de la zone';
    sLMDSysInetPropDescZoneName = '';
  sLMDSysInetPropTitleZoneDescription = 'Description';
    sLMDSysInetPropDescZoneDescription = '';
  sLMDSysInetPropTitleZoneSites = 'Sites';
    sLMDSysInetPropDescZoneSites = '';
  sLMDSysInetPropTitlePath = 'Emplacement fichiers temporaires';
    sLMDSysInetPropDescPath = '';
  sLMDSysInetPropTitleMaxSize = 'Espace disque � utiliser';
    sLMDSysInetPropDescMaxSize = '';
  sLMDSysInetPropTitleHomePage = 'Page de d�marrage';
    sLMDSysInetPropDescHomePage = '';
  sLMDSysInetPropTitleHTMLEditor = 'Editeur HTML';
    sLMDSysInetPropDescHTMLEditor = '';
  sLMDSysInetPropTitleEMailClient = 'Client de messagerie';
    sLMDSysInetPropDescEMailClient = '';
  sLMDSysInetPropTitleNewsClient = 'Client de newsgroups';
    sLMDSysInetPropDescNewsClient = '';
  sLMDSysInetPropTitleCalendar = 'Calendrier';
    sLMDSysInetPropDescCalendar = '';
  sLMDSysInetPropTitleInetCall = 'InetCall';
    sLMDSysInetPropDescInetCall = '';
  sLMDSysInetPropTitleContacts = 'Contacts';
    sLMDSysInetPropDescContacts = '';

  // Modem section
  sLMDSysModemGroupTitle = 'Modems';
    sLMDSysModemGroupDesc = '';
  sLMDSysModemTitle = 'Modem';
    sLMDSysModemDesc = '';

  sLMDSysModemTitleName = 'Nom';
    sLMDSysModemDescName = '';
  sLMDSysModemTitleAttachedTo = 'Attach� �';
    sLMDSysModemDescAttachedTo = '';
  sLMDSysModemTitleUserInit = 'Commandes d''initialisation';
    sLMDSysModemDescUserInit = '';
  sLMDSysModemTitlePortSpeed = 'Vitesse du port';
    sLMDSysModemDescPortSpeed = '';

  // Network section
  sLMDSysNetServiceNameTitle = 'Nom du service';
    sLMDSysNetServiceNameDesc = '';
  sLMDSysNetDescriptionTitle = 'Description';
    sLMDSysNetDescriptionDesc = '';

  sLMDSysNetUserNameTitle = 'Nom de l''utilisateur';
    sLMDSysNetUserNameDesc = '';
  sLMDSysNetComputerNameTitle = 'Nom de la machine';
    sLMDSysNetComputerNameDesc = '';


  sLMDSysTCPIPTitle = 'TCP/IP';
    sLMDSysTCPIPDesc = '';
  sLMDSysIPXTitle = 'IPX';
    sLMDSysIPXDesc = '';
  sLMDSysNetBEUITitle = 'NetBEUI';
    sLMDSysNetBEUIDesc = '';
  sLMDSysNetworkTitle = 'R�seau';
    sLMDSysNetworkDesc = '';
  sLMDSysNetworkCardTitle = 'Carte r�seau';
    sLMDSysNetworkCardDesc = '';
  sLMDSysNetworkCardGroupTitle = 'Cartes r�seau';
    sLMDSysNetworkCardGroupDesc = '';


  sLMDSysProtocolPropTitleInstalled = 'Install�';
    sLMDSysProtocolPropDescInstalled = '';
  sLMDSysTCPIPPropTitleIPAddress = 'Addresse IP';
    sLMDSysTCPIPPropDescIPAddress = '';
  sLMDSysTCPIPPropTitleIPSubnetMask = 'Masque de sous-r�seau';
    sLMDSysTCPIPPropDescIPSubnetMask = '';
  sLMDSysTCPIPPropTitleDefaultGateway = 'Passerelle par d�faut';
    sLMDSysTCPIPPropDescDefaultGateway = '';
  sLMDSysIPXPropTitleNetworkNumber = 'NetworkNumber';
    sLMDSysIPXPropDescNetworkNumber = '';
  sLMDSysTCPIPPropTitleDHCPEnabled= 'DHCP activ�';
    sLMDSysTCPIPPropDescDHCPEnabled= '';


  //WMI common properties

  sLMDSysAvailabilityUnDefined = 'Ind�fini';
  sLMDSysAvailabilityOther = 'Autre';
  sLMDSysAvailabilityUnknown = 'Inconnu';
  sLMDSysAvailabilityRunning = 'En cours';
  sLMDSysAvailabilityWarning = 'Attention';
  sLMDSysAvailabilityInTest = 'En test';
  sLMDSysAvailabilityNotApplicable = 'Non applicable';
  sLMDSysAvailabilityPowerOff = 'PowerOff';
  sLMDSysAvailabilityOffLine = 'OffLine';
  sLMDSysAvailabilityOffDuty = 'OffDuty';
  sLMDSysAvailabilityDegraded = 'D�grad�';
  sLMDSysAvailabilityNotInstalled = 'Non install�';
  sLMDSysAvailabilityInstallError = 'Erreur d''installation';
  sLMDSysAvailabilityPowerSaveUnknown = 'PowerSaveUnknown';
  sLMDSysAvailabilityPowerSaveLowPowerMode = 'PowerSaveLowPowerMode';
  sLMDSysAvailabilityPowerSaveStandby = 'PowerSaveStandby';
  sLMDSysAvailabilityPowerCycle = 'PowerCycle';
  sLMDSysAvailabilityPowerSaveWarning = 'PowerSaveWarning';

  sLMDSysPMCpmUnknown = 'Inconnu';
  sLMDSysPMCpmNotSupported = 'Non support�';
  sLMDSysPMCpmDisabled = 'D�sactiv�';
  sLMDSysPMCpmEnabled = 'Activ�';
  sLMDSysPMCpmPowerSavingModesEnteredAutomatically = 'PowerSavingModesEnteredAutomatically';
  sLMDSysPMCpmPowerStateSettable = 'PowerStateSettable';
  sLMDSysPMCpmPowerCyclingSupported = 'PowerCyclingSupported';
  sLMDSysPMCpmTimedPowerOnSupported = 'TimedPowerOnSupported';

  sLMDSysSIUndefined = 'Ind�fini';
  sLMDSysSIOther = 'Autre';
  sLMDSysSIUnknown = 'Inconnu';
  sLMDSysSIEnabled = 'Activ�';
  sLMDSysSIDisabled = 'D�sactiv�';
  sLMDSysSINotApplicable = 'Non applicable';

implementation

end.
