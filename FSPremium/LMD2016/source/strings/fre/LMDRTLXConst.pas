unit LMDRTLXConst;
{###############################################################################

LMDRTLXConst unit (AH)
---------------------
This unit contains Resource Strings for the LMD-Tools RTLX package.

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // LMDConversion
// Units
 SLMD_U_POINTS = 'Points';
 SLMD_U_INCHES100 = 'Inches x 100';
 SLMD_U_MILLIMETERS = 'Millimeters';

  // LMDWave
  IDS_WAVEFILTER='Wave-Files (*.wav)|*.wav';
  // LMDPNG
  SLMDPNGDifferentBitDepth = 'Source and destanation have different bit depth';
  SLMDPNGInvalidSourceSize = 'Source rect is bigger than destination size';
  SLMDPNGInvalidNewSize = 'The new size provided for image resizing is invalid.';
  SLMDPNGInvalidSpec = 'The "Portable Network Graphics" could not be created ' +
    'because invalid image type parameters have being provided.';
  SLMDPNGInvalidCRCText = 'Cette image PNG n'#39'est pas valide ' +
      'car elle contient des donn�es incorectes (crc error).';
  SLMDPNGInvalidIHDRText = 'L'#39'image PNG ne peut pas �tre charg�e ' +
      ' car une donn�e importante (ihdr) doit �tre corrompue.';
  SLMDPNGMissingMultipleIDATText = 'Cette image PNG n'#39'est pas valide ' +
    'car il manque des morceaux de l'#39' image.';
  SLMDPNGZLIBErrorText = 'Impossible de d�compresser cette image car elle contient ' +
    'des donn�es compress�es non valides.'#13#10 + ' Description: ';
  SLMDPNGInvalidPaletteText = 'L'#39'image PNG contient une palette non valide.';
  SLMDPNGInvalidFileHeaderText = 'Le fichier n'#39'est pas une image PNG valide '+
    'car il contient un en-t�te corrompu.' +
    ' Ce fichier doit �tre corrompu.';
  SLMDPNGIHDRNotFirstText = 'Cette image PNG n'#39'est pas support�e ' +
    'ou est invalide.'#13#10 + '(IHDR chunk is not the first)';
  SLMDPNGNotExistsText = 'L'#39'image PNG ne peut pas �tre charg�e car le fichier ' +
    'n'#39'existe pas.';
  SLMDPNGSizeExceedsText = 'Cette image PNG n'#39'est pas support�e ' +
    'car sa largeur ou sa hauteur d�passe le maximum  ' +
    'qui est de 65535 pixels.';
  SLMDPNGUnknownPalEntryText = 'Il y a aucune entr�e de palette.';
  SLMDPNGMissingPaletteText = 'Cette image PNG ne peut pas �tre charg�e car  ' +
    'elle utilise une table de couleurs qui est manquante.';
  SLMDPNGUnknownCriticalChunkText = 'Cette image PNG contient ' +
    'une partie importante qui ne peut pas �tre d�cod�e.';
  SLMDPNGUnknownCompressionText = 'Cette image PNG est encod�e avec une compression' +
    'inconnue qui ne peut pas �tre d�cod�e.';
  SLMDPNGUnknownInterlaceText = 'Cette image PNG utilise un arrangement inconnu ' +
    'd'#39'entrelacement qui ne peut pas �tre d�cod�.';
  SLMDPNGCannotAssignChunkText = 'The chunks doit �tre compatible pour �tre assign�.';
  SLMDPNGUnexpectedEndText = 'Cette image PNG est non valide ' +
    'car le d�codeur a trouv� une fin de fichier anormale.';
  SLMDPNGNoImageDataText = 'Cette image PNG ne contient pas de ' +
    'donn�es.';
  SLMDPNGCannotChangeSizeText = 'L'#39'image PNG ne peut pas �tre redimensionn�e' +
    'en changeant la largeur et la hauteur. Assigner une image ' +
    '� partir d'#39'un bitmap.';
  SLMDPNGCannotAddChunkText = 'Le programme essaie d'#39'ajouter un morceau critique existant' +
    '� l'#39'image en cours ce qui n'#39'est pas permis.';
  SLMDPNGCannotAddInvalidImageText = 'Impossible d'#39'ajouter un nouveau chunk ' +
    'car l'#39'image est non valide.';
  SLMDPNGCouldNotLoadResourceText = 'L'#39'image PNG ne peut pas �tre charg�e ' +
    '� partir de la ressource.';
  SLMDPNGOutMemoryText = 'Une op�ration ne peut �tre effectu�e car le syst�me ' +
    'est � cours de ressources. Fermer des fen�tres et r�essayer.';
  SLMDPNGCannotChangeTransparentText = 'D�finir une couleur transparente n'#39'est pas autoris� ' +
    'pour les images PNG contenant une valeur alpha pour chaque pixel ' +
    '(COLOR_RGBALPHA et COLOR_GRAYSCALEALPHA)';
  SLMDPNGHeaderNotPresentText = 'Cette op�ration est non valide car ' +
    'l'#39'image ne contient pas d'#39'en-t�te valide.';
  //Theme engine
  SLMDThemesOneInst = 'Only one instance of TLMDThemeEngine can be created';

  SLMDThemeFileParseFailed = 'Theme file [%s] parse failed.';
  SLMDInvalidThemeFileName = 'Nom de fichier du th�me non valide [%s]';
  SLMDUnknownTheme = 'Th�me inconnu [%s]';
  SLMDUnknownThemePart = 'Partie de th�me inconnue [%d]';
  SLMDUnknownThemeColorScheme = 'Couleur de th�me inconnue [%s]';
  SLMDUnknownThemeBool = 'Syst�me m�trique inconnu. bool�en [%d]';
  SLMDUnknownThemeColor = 'Syst�me m�trique inconnu. couleur [%d]';
  SLMDUnknownThemeFont = 'Syst�me m�trique inconnu. police [%d]';
  SLMDUnknownThemeInt = 'Syst�me m�trique inconnu. int [%d]';
  SLMDUnknownThemeSize = 'Syst�me m�trique inconnu. taille [%d]';
  SLMDUnknownThemeString = 'Syst�me m�trique inconnu. chaine [%d]';
  SLMDInvalidRefCount = 'Valeur RefCount non valide dans [%s]';
  SLMDInvalidImageCount = 'Nombre d'#39'images [%d] non valide';

  SLMDWinXPThemeNoDisplayName = 'Pas de nom pour ce th�me';
  SLMDWinXPThemeInvalidParameter = 'Param�tre de fonction non valide';
  SLMDWinXPThemeNoDocProp = 'La documentation de la propri�t� [%s] est ind�finie';
  SLMDWinXPThemeNoSchemeSection = 'Impossible de trouver une section appropri�e';
  SLMDWinXPThemeNoMetricsProp = 'La propri�t� [%d] du syst�me m�trique est ind�finie';
  SLMDWinXPThemeNoSchemeProp = 'La propri�t� [%d] du th�me est ind�finie';
  SLMDWinXPThemeTextMetricFailed = 'Failed to get text metric';

  // TLMDMRUList
  IDS_CLEARLIST = 'Clear List...';
  IDS_CLEARLISTHINT = 'Clear recent files list';
  IDS_CLEARLISTREQUEST = 'Really clear recent files list?';

  // Cab File support
  SLMDCabNoMultiPart='MultiPart Cab Files not supported';
  SLMDCabUnknownErrorCode='Unknown error code';
  SLMDCabNone = 'No error';
  SLMDCabAllocFail = 'Out of memory';
  SLMDCabBadCompressType = 'Unknown compression type';
  SLMDCabUserAbort = 'Operation aborted by user';
  // FDI Errors
  SLMDCabFDICabinetNotFound ='Cabinet file not found';
  SLMDCabFDINotACabinet ='File not in CAB format';
  SLMDCabFDIUnknownCABVersion = 'Unknown CAB file version';
  SLMDCabFDICorruptCAB = 'Cabinet file is corrupt';
  SLMDCabFDIMDIFail = 'Decompression error';
  SLMDCabFDITargetFile = 'Error writing to destination file';
  SLMDCabFDIReserveMismatch = 'Reserve size mismatch';
  SLMDCabFDIWrongCabinet = 'Incorrect CAB returned';
  // FCI Errors
  SLMDCabFCIOPENSRC = 'Error opening source file';
  SLMDCabFCIREADSRC = 'Error reading from source file';
  SLMDCabFCITEMPFILE = 'TempFile could not be created';
  SLMDCabFCICABFILE = 'Cabinet file could bot be created';
  SLMDCabFDIMCIFAIL = 'Compression error';

  //
  SHLSToRGBConvertError = 'HLS to RGB convert error';

implementation

end.