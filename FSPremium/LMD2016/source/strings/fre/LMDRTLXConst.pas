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
      'car elle contient des données incorectes (crc error).';
  SLMDPNGInvalidIHDRText = 'L'#39'image PNG ne peut pas être chargée ' +
      ' car une donnée importante (ihdr) doit être corrompue.';
  SLMDPNGMissingMultipleIDATText = 'Cette image PNG n'#39'est pas valide ' +
    'car il manque des morceaux de l'#39' image.';
  SLMDPNGZLIBErrorText = 'Impossible de décompresser cette image car elle contient ' +
    'des données compressées non valides.'#13#10 + ' Description: ';
  SLMDPNGInvalidPaletteText = 'L'#39'image PNG contient une palette non valide.';
  SLMDPNGInvalidFileHeaderText = 'Le fichier n'#39'est pas une image PNG valide '+
    'car il contient un en-tête corrompu.' +
    ' Ce fichier doit être corrompu.';
  SLMDPNGIHDRNotFirstText = 'Cette image PNG n'#39'est pas supportée ' +
    'ou est invalide.'#13#10 + '(IHDR chunk is not the first)';
  SLMDPNGNotExistsText = 'L'#39'image PNG ne peut pas être chargée car le fichier ' +
    'n'#39'existe pas.';
  SLMDPNGSizeExceedsText = 'Cette image PNG n'#39'est pas supportée ' +
    'car sa largeur ou sa hauteur dépasse le maximum  ' +
    'qui est de 65535 pixels.';
  SLMDPNGUnknownPalEntryText = 'Il y a aucune entrée de palette.';
  SLMDPNGMissingPaletteText = 'Cette image PNG ne peut pas être chargée car  ' +
    'elle utilise une table de couleurs qui est manquante.';
  SLMDPNGUnknownCriticalChunkText = 'Cette image PNG contient ' +
    'une partie importante qui ne peut pas être décodée.';
  SLMDPNGUnknownCompressionText = 'Cette image PNG est encodée avec une compression' +
    'inconnue qui ne peut pas être décodée.';
  SLMDPNGUnknownInterlaceText = 'Cette image PNG utilise un arrangement inconnu ' +
    'd'#39'entrelacement qui ne peut pas être décodé.';
  SLMDPNGCannotAssignChunkText = 'The chunks doit être compatible pour être assigné.';
  SLMDPNGUnexpectedEndText = 'Cette image PNG est non valide ' +
    'car le décodeur a trouvé une fin de fichier anormale.';
  SLMDPNGNoImageDataText = 'Cette image PNG ne contient pas de ' +
    'données.';
  SLMDPNGCannotChangeSizeText = 'L'#39'image PNG ne peut pas être redimensionnée' +
    'en changeant la largeur et la hauteur. Assigner une image ' +
    'à partir d'#39'un bitmap.';
  SLMDPNGCannotAddChunkText = 'Le programme essaie d'#39'ajouter un morceau critique existant' +
    'à l'#39'image en cours ce qui n'#39'est pas permis.';
  SLMDPNGCannotAddInvalidImageText = 'Impossible d'#39'ajouter un nouveau chunk ' +
    'car l'#39'image est non valide.';
  SLMDPNGCouldNotLoadResourceText = 'L'#39'image PNG ne peut pas être chargée ' +
    'à partir de la ressource.';
  SLMDPNGOutMemoryText = 'Une opération ne peut être effectuée car le système ' +
    'est à cours de ressources. Fermer des fenêtres et réessayer.';
  SLMDPNGCannotChangeTransparentText = 'Définir une couleur transparente n'#39'est pas autorisé ' +
    'pour les images PNG contenant une valeur alpha pour chaque pixel ' +
    '(COLOR_RGBALPHA et COLOR_GRAYSCALEALPHA)';
  SLMDPNGHeaderNotPresentText = 'Cette opération est non valide car ' +
    'l'#39'image ne contient pas d'#39'en-tête valide.';
  //Theme engine
  SLMDThemesOneInst = 'Only one instance of TLMDThemeEngine can be created';

  SLMDThemeFileParseFailed = 'Theme file [%s] parse failed.';
  SLMDInvalidThemeFileName = 'Nom de fichier du thème non valide [%s]';
  SLMDUnknownTheme = 'Thème inconnu [%s]';
  SLMDUnknownThemePart = 'Partie de thème inconnue [%d]';
  SLMDUnknownThemeColorScheme = 'Couleur de thème inconnue [%s]';
  SLMDUnknownThemeBool = 'Système métrique inconnu. booléen [%d]';
  SLMDUnknownThemeColor = 'Système métrique inconnu. couleur [%d]';
  SLMDUnknownThemeFont = 'Système métrique inconnu. police [%d]';
  SLMDUnknownThemeInt = 'Système métrique inconnu. int [%d]';
  SLMDUnknownThemeSize = 'Système métrique inconnu. taille [%d]';
  SLMDUnknownThemeString = 'Système métrique inconnu. chaine [%d]';
  SLMDInvalidRefCount = 'Valeur RefCount non valide dans [%s]';
  SLMDInvalidImageCount = 'Nombre d'#39'images [%d] non valide';

  SLMDWinXPThemeNoDisplayName = 'Pas de nom pour ce thème';
  SLMDWinXPThemeInvalidParameter = 'Paramètre de fonction non valide';
  SLMDWinXPThemeNoDocProp = 'La documentation de la propriété [%s] est indéfinie';
  SLMDWinXPThemeNoSchemeSection = 'Impossible de trouver une section appropriée';
  SLMDWinXPThemeNoMetricsProp = 'La propriété [%d] du système métrique est indéfinie';
  SLMDWinXPThemeNoSchemeProp = 'La propriété [%d] du thème est indéfinie';
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