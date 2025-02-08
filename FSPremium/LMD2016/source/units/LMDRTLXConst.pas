unit LMDRTLXConst;

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDRTLXConst unit (AH)
---------------------
This unit contains Resource Strings for the LMD-Tools RTLX package.

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

  {$R LMDBMPX.res}

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
  SLMDPNGInvalidCRCText = 'This "Portable Network Graphics" image is not valid ' +
      'because it contains invalid pieces of data (crc error)';
  SLMDPNGInvalidIHDRText = 'The "Portable Network Graphics" image could not be ' +
      'loaded because one of its main piece of data (ihdr) might be corrupted';
  SLMDPNGMissingMultipleIDATText = 'This "Portable Network Graphics" image is ' +
    'invalid because it has missing image parts.';
  SLMDPNGZLIBErrorText = 'Could not decompress the image because it contains ' +
    'invalid compressed data.'#13#10 + ' Description: ';
  SLMDPNGInvalidPaletteText = 'The "Portable Network Graphics" image contains ' +
    'an invalid palette.';
  SLMDPNGInvalidFileHeaderText = 'The file being readed is not a valid '+
    '"Portable Network Graphics" image because it contains an invalid header.' +
    ' This file may be corrupted, try obtaining it again.';
  SLMDPNGIHDRNotFirstText = 'This "Portable Network Graphics" image is not ' +
    'supported or it might be invalid.'#13#10 + '(IHDR chunk is not the first)';
  SLMDPNGNotExistsText = 'The png file could not be loaded because it does not ' +
    'exists.';
  SLMDPNGSizeExceedsText = 'This "Portable Network Graphics" image is not ' +
    'supported because either it''s width or height exceeds the maximum ' +
    'size, which is 65535 pixels length.';
  SLMDPNGUnknownPalEntryText = 'There is no such palette entry.';
  SLMDPNGMissingPaletteText = 'This "Portable Network Graphics" could not be ' +
    'loaded because it uses a color table which is missing.';
  SLMDPNGUnknownCriticalChunkText = 'This "Portable Network Graphics" image ' +
    'contains an unknown critical part which could not be decoded.';
  SLMDPNGUnknownCompressionText = 'This "Portable Network Graphics" image is ' +
    'encoded with an unknown compression scheme which could not be decoded.';
  SLMDPNGUnknownInterlaceText = 'This "Portable Network Graphics" image uses ' +
    'an unknown interlace scheme which could not be decoded.';
  SLMDPNGCannotAssignChunkText = 'The chunks must be compatible to be assigned.';
  SLMDPNGUnexpectedEndText = 'This "Portable Network Graphics" image is invalid ' +
    'because the decoder found an unexpected end of the file.';
  SLMDPNGNoImageDataText = 'This "Portable Network Graphics" image contains no ' +
    'data.';
  SLMDPNGCannotChangeSizeText = 'The "Portable Network Graphics" image can not ' +
    'be resize by changing width and height properties. Try assigning the ' +
    'image from a bitmap.';
  SLMDPNGCannotAddChunkText = 'The program tried to add a existent critical ' +
    'chunk to the current image which is not allowed.';
  SLMDPNGCannotAddInvalidImageText = 'It''s not allowed to add a new chunk ' +
    'because the current image is invalid.';
  SLMDPNGCouldNotLoadResourceText = 'The png image could not be loaded from the ' +
    'resource ID.';
  SLMDPNGOutMemoryText = 'Some operation could not be performed because the ' +
    'system is out of resources. Close some windows and try again.';
  SLMDPNGCannotChangeTransparentText = 'Setting bit transparency color is not ' +
    'allowed for png images containing alpha value for each pixel ' +
    '(COLOR_RGBALPHA and COLOR_GRAYSCALEALPHA)';
  SLMDPNGHeaderNotPresentText = 'This operation is not valid because the ' +
    'current image contains no valid header.';

  //Theme engine
  SLMDThemesOneInst = 'Only one instance of TLMDThemeEngine can be created';

  SLMDThemeFileParseFailed = 'Theme file [%s] parse failed.';
  SLMDInvalidThemeFileName = 'Invalid theme file name [%s]';
  SLMDUnknownTheme = 'Unknown theme [%s]';
  SLMDUnknownThemePart = 'Unknown theme part [%d]';
  SLMDUnknownThemeColorScheme = 'Unknown theme color scheme [%s]';
  SLMDUnknownThemeBool = 'Unknown system metric boolean [%d]';
  SLMDUnknownThemeColor = 'Unknown system metric color [%d]';
  SLMDUnknownThemeFont = 'Unknown system metric font [%d]';
  SLMDUnknownThemeInt = 'Unknown system metric int [%d]';
  SLMDUnknownThemeSize = 'Unknown system metric size [%d]';
  SLMDUnknownThemeString = 'Unknown system metric string [%d]';
  SLMDInvalidRefCount = 'Invalid RefCount value in [%s]';
  SLMDInvalidImageCount = 'Invalid image count [%d]';

  SLMDWinXPThemeNoDisplayName = 'No display name for this theme';
  SLMDWinXPThemeInvalidParameter = 'Invalid function parameter';
  SLMDWinXPThemeNoDocProp = 'Documenation property [%s] is undefined';
  SLMDWinXPThemeNoSchemeSection = 'Cannot find an appropriate scheme section';
  SLMDWinXPThemeNoMetricsProp = 'System metrics property [%d] is undefined';
  SLMDWinXPThemeNoSchemeProp = 'Theme property [%d] is undefined';
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
