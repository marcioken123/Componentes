unit LMDSysConst;
{###############################################################################

LMDSysConst unit (JH)
---------------------
Resource strings for LMD SysPack.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  sLMDSysNOTAVAILABLE='n/a';
  sLMDSysNone='None';
  sLMDSysFirst='1st';
  sLMDSysSecond='2nd';
  sLMDSysThird='3rd';
  sLMDSysFourth='4th';
  sLMDSysLast='Last';
  sLMDSysUnknown = 'Unknown';
  sLMDSysof = 'of';

  // Center
  cLMDSysInfoTitle = 'System Information Center';
  cLMDSysInfoDesc = '';

  // DriveTypes
  sLMDSysNOROOTDIR = 'No Root Directory';
  sLMDSysREMOVABLE = 'Floppy';
  sLMDSysFIXEDDRIVE = 'Fixed';
  sLMDSysREMOTE = 'Network';
  sLMDSysCDROM = 'CD-ROM';
  sLMDSysRAMDISK = 'RAM';

  //TLMDSysWindowsObject
  sLMDSysElapsedTime='%d days %d hours %d minutes %d seconds';
  // Network
  sLMDSysNetwork='Network';

  // Event Log
  sLMDSysMessageDLLNOTFOUNT='Resource DLL for localized messages not found';
  sLMDSysEventDlgError='No Event Log could open or item(s) do(es) not exist.';
  sLMDSysEventNotOpen='Event Log not opened';

  sLMDsysEventTypeError='Error';
  sLMDsysEventTypeWarning='Warning';
  sLMDsysEventTypeInformation='Information';
  sLMDsysEventTypeAuditSuccess='Audit Success';
  sLMDsysEventTypeAuditFailure='Audit Failure';

  sLMDSysEventEvent='Event';
  sLMDSysEventDate='Date';
  sLMDSysEventTime='Time';
  sLMDSysEventType='Type';
  sLMDSysEventSource='Source';
  sLMDSysEventUser='User';
  sLMDSysEventCategory='Category';
  sLMDSysEventComputer='Computer';

  sLMDSysEventDlgCaption='Event Details';
  sLMDSysEventDlgEventIDLabel='EventID:';
  sLMDSysEventDlgDescriptionLabel='Description:';

  // System Folder Names:
  sLMDSysFolderDesktop='Desktop';
  sLMDSysFolderMyComputer='MyComputer';
  sLMDSysFolderPrograms='Programs';
  sLMDSysFolderControlPanel='ControlPanel';
  sLMDSysFolderPrinters='Printers';
  sLMDSysFolderPersonal='MyDocuments';
  sLMDSysFolderFavorites='Favorites';
  sLMDSysFolderStartup='Startup';
  sLMDSysFolderRecent='Recent';
  sLMDSysFolderSendto='SendTo';
  sLMDSysFolderRecycleBin='RecycleBin';
  sLMDSysFolderStartMenu='StartMenu';
  sLMDSysFolderDesktopDirectory='DesktopDirectory';
  sLMDSysFolderNetwork='Network';
  sLMDSysFolderNetworkNeighborhood='NetHood';
  sLMDSysFolderInternet='Internet';
  sLMDSysFolderFonts='Fonts';
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
  sLMDSysFolderMyVideo='MyVideo';
  sLMDSysFolderCommonVideo='CommonVideo';
  sLMDSysFolderMyPictures='MyPictures';
  sLMDSysFolderCommonPictures='CommonPictures';
  sLMDSysFolderMyMusic='MyMusic';
  sLMDSysFolderCommonMusic='CommonMusic';
  sLMDSysFolderMyDocuments='MyDocuments';
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
  sLMDSysMouseObjectTitle = 'Mouse';
    sLMDSysMouseObjectDesc = 'Pointing Device';
  sLMDSysMousePropTitleDoubleClickTime = 'DoubleClickTime';
    sLMDSysMousePropDescDoubleClickTime = 'Double click time';
  sLMDSysMousePropTitleDoubleClickWidth = 'DoubleClickWidth';
    sLMDSysMousePropDescDoubleClickWidth = 'Width , in pixels, of the rectangle around the location of a first click in a double-click sequence';
  sLMDSysMousePropTitleDoubleClickHeight = 'DoubleClickHeight';
    sLMDSysMousePropDescDoubleClickHeight = 'Height, in pixels, of the rectangle around the location of a first click in a double-click sequence';
  sLMDSysMousePropTitleSpeed = 'Speed';
    sLMDSysMousePropDescSpeed = 'Retrieves the current mouse speed';
  sLMDSysMousePropTitleButtons = 'Buttons';
    sLMDSysMousePropDescButtons = 'Number of buttons on the mouse';
  sLMDSysMousePropTitleSwapButtons = 'SwapButtons';
    sLMDSysMousePropDescSwapButtons = 'Left and right mouse buttons are swapped';
  sLMDSysMousePropTitleExist = 'Exist';
    sLMDSysMousePropDescExist = 'Indicates whether the device can be used';
  sLMDSysMousePropTitleHasWheel = 'HasWheel';
    sLMDSysMousePropDescHasWheel = 'Indicates whether a wheel is installed';
  sLMDSysMousePropTitleSnapToDefault = 'SnapToDefault';
    sLMDSysMousePropDescSnapToDefault = 'Determines whether the snap-to-default-button feature is enabled';
  sLMDSysMousePropTitleCursorScheme = 'CursorScheme';
    sLMDSysMousePropDescCursorScheme = 'Cursor scheme';
  sLMDSysMousePropTitleCursorSchemes = 'CursorSchemes';
    sLMDSysMousePropDescCursorSchemes = 'Cursor schemes';

  sLMDSysMousePropTitleAvailability = 'Availability';
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
  sLMDSysMousePropTitleHardwareType = 'HardwareType';
    sLMDSysMousePropDescHardwareType = '';
  sLMDSysMousePropTitleInfFileName = 'InfFileName';
    sLMDSysMousePropDescInfFileName = '';
  sLMDSysMousePropTitleInfSection = 'InfSection';
    sLMDSysMousePropDescInfSection = '';
  sLMDSysMousePropTitleInstallDate = 'InstallDate';
    sLMDSysMousePropDescInstallDate = '';
  sLMDSysMousePropTitleIsLocked = 'IsLocked';
    sLMDSysMousePropDescIsLocked = '';
  sLMDSysMousePropTitleLastErrorCode = 'LastErrorCode';
    sLMDSysMousePropDescLastErrorCode = '';
  sLMDSysMousePropTitleManufacturer = 'Manufacturer';
    sLMDSysMousePropDescManufacturer = '';
  sLMDSysMousePropTitleName = 'Name';
    sLMDSysMousePropDescName = '';
  sLMDSysMousePropTitlePowerManagementCapabilities = 'PowerManagementCapabilities';
    sLMDSysMousePropDescPowerManagementCapabilities = '';
  sLMDSysMousePropTitlePowerManagementSupported = 'PowerManagementSupported';
    sLMDSysMousePropDescPowerManagementSupported = '';
  sLMDSysMousePropTitleQuadSpeedThreshold = 'QuadSpeedThreshold';
    sLMDSysMousePropDescQuadSpeedThreshold = '';
  sLMDSysMousePropTitleResolution = 'Resolution';
    sLMDSysMousePropDescResolution = '';
  sLMDSysMousePropTitleSampleRate = 'SampleRate';
    sLMDSysMousePropDescSampleRate = '';
  sLMDSysMousePropTitleStatus = 'Status';
    sLMDSysMousePropDescStatus = '';
  sLMDSysMousePropTitleStatusInfo = 'StatusInfo';
    sLMDSysMousePropDescStatusInfo = '';
  sLMDSysMousePropTitleSynch = 'Synch';
    sLMDSysMousePropDescSynch = '';


  // Display section
  sLMDSysDisplayObjectTitle = 'Display';
    sLMDSysDisplayObjectDesc = 'Output device';
  sLMDSysDisplayModeObjectTitle = 'Display mode';
    sLMDSysDisplayModeObjectDesc = 'Display mode';
  sLMDSysDisplayPlusObjectTitle = 'Plus';
    sLMDSysDisplayPlusObjectDesc = 'Plus';
  sLMDSysDisplayScreenSaverObjectTitle = 'Screen Saver';
    sLMDSysDisplayScreenSaverObjectDesc = 'Screen Saver';
  sLMDSysDisplayWallpaperObjectTitle = 'Wallpaper';
    sLMDSysDisplayWallpaperObjectDesc = 'Wallpaper';

  sLMDSysDisplayModePropTitleWidth = 'Width';
    sLMDSysDisplayModePropDescWidth = '';
  sLMDSysDisplayModePropTitleHeight = 'Height';
    sLMDSysDisplayModePropDescHeight = '';
  sLMDSysDisplayModePropTitleFrequency = 'Frequency';
    sLMDSysDisplayModePropDescFrequency = '';
  sLMDSysDisplayModePropTitleBitsPerPixel = 'BitsPerPixel';
    sLMDSysDisplayModePropDescBitsPerPixel = '';
  sLMDSysDisplayModePropTitleMonochrome = 'Monochrome';
    sLMDSysDisplayModePropDescMonochrome = '';
  sLMDSysDisplayModePropTitleInterlaced = 'Interlaced';
    sLMDSysDisplayModePropDescInterlaced = '';
  sLMDSysDisplayModePropTitleColors = 'Colors';
    sLMDSysDisplayModePropDescColors = '';

  sLMDSysDisplayPlusPropTitleAvailable = 'Available';
    sLMDSysDisplayPlusPropDescAvailable = '';
  sLMDSysDisplayPlusPropTitleFontSmoothing = 'FontSmoothing';
    sLMDSysDisplayPlusPropDescFontSmoothing = '';
  sLMDSysDisplayPlusPropTitleWindowAnimation = 'WindowAnimation';
    sLMDSysDisplayPlusPropDescWindowAnimation = '';
  sLMDSysDisplayPlusPropTitleDragFullWindows = 'DragFullWindows';
    sLMDSysDisplayPlusPropDescDragFullWindows = '';

  sLMDSysDisplayScreenSaverPropTitleActive = 'Active';
    sLMDSysDisplayScreenSaverPropDescActive = '';
  sLMDSysDisplayScreenSaverPropTitleDelay = 'Delay';
    sLMDSysDisplayScreenSaverPropDescDelay = '';
  sLMDSysDisplayScreenSaverPropTitleSecure = 'Secure';
    sLMDSysDisplayScreenSaverPropDescSecure = '';
  sLMDSysDisplayScreenSaverPropTitleRunning = 'Running';
    sLMDSysDisplayScreenSaverPropDescRunning = '';
  sLMDSysDisplayScreenSaverPropTitleScreenSaver = 'ScreenSaver';
    sLMDSysDisplayScreenSaverPropDescScreenSaver = '';
  sLMDSysDisplayScreenSaverPropTitleScreenSavers = 'ScreenSavers';
    sLMDSysDisplayScreenSaverPropDescScreenSavers = '';

  sLMDSysDisplayWallpaperPropTitleFilename = 'Filename';
    sLMDSysDisplayWallpaperPropDescFilename = '';
  sLMDSysDisplayWallpaperPropTitleTile = 'Tile';
    sLMDSysDisplayWallpaperPropDescTile = '';
  sLMDSysDisplayWallpaperPropTitleStretch = 'Stretch';
    sLMDSysDisplayWallpaperPropDescStretch = '';
  sLMDSysDisplayWallpaperPropTitlePatterns = 'Patterns';
    sLMDSysDisplayWallpaperPropDescPatterns = '';
  sLMDSysDisplayWallpaperPropTitlePattern = 'Pattern';
    sLMDSysDisplayWallpaperPropDescPattern = '';

  // Drive object section
  sLMDSysDriveObjectTitle = 'Drive';
    sLMDSysDriveObjectDesc = 'Drive device';

  sLMDSysDrivePropTitleBytesPerSector = 'BytesPerSector';
    sLMDSysDrivePropDescBytesPerSector = '';
  sLMDSysDrivePropTitleDiskSize = 'DiskSize';
    sLMDSysDrivePropDescDiskSize = '';
  sLMDSysDrivePropTitleDiskFree = 'DiskFree';
    sLMDSysDrivePropDescDiskFree = '';
  sLMDSysDrivePropTitleDrive = 'Drive';
    sLMDSysDrivePropDescDrive = '';
  sLMDSysDrivePropTitleDriveType = 'DriveType';
    sLMDSysDrivePropDescDriveType = '';
  sLMDSysDrivePropTitleFileSystem = 'FileSystem';
    sLMDSysDrivePropDescFileSystem = '';
  sLMDSysDrivePropTitleSectorsPerCluster = 'SectorsPerCluster';
    sLMDSysDrivePropDescSectorsPerCluster = '';
  sLMDSysDrivePropTitleMaximumLength = 'MaximumLength';
    sLMDSysDrivePropDescMaximumLength = '';
  sLMDSysDrivePropTitleSerialNumber = 'SerialNumber';
    sLMDSysDrivePropDescSerialNumber = '';
  sLMDSysDrivePropTitleOptions = 'Options';
    sLMDSysDrivePropDescOptions = '';
  sLMDSysDrivePropTitleVolumeLabel = 'VolumeLabel';
    sLMDSysDrivePropDescVolumeLabel = '';

  sLMDSysDriveOptionCaseIsPreserved = 'CaseIsPreserved';
  sLMDSysDriveOptionCaseSensitive = 'CaseSensitive';
  sLMDSysDriveOptionSupportsUnicode = 'SupportsUnicode';
  sLMDSysDriveOptionPersistentACLs = 'PersistentACLs';
  sLMDSysDriveOptionSupportsCompression = 'SupportsCompression';
  sLMDSysDriveOptionIsCompressed = 'IsCompressed';
  sLMDSysDriveOptionSupportsQuotas = 'SupportsQuotas';

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
  sLMDSysPrinterObjectsTitle = 'Printers';
    sLMDSysPrinterObjectsDesc = '';
  sLMDSysPrinterObjectTitle = 'Printer';
    sLMDSysPrinterObjectDesc = '';

  sLMDSysPrinterPropTitleDeviceName = 'DeviceName';
    sLMDSysPrinterPropDescDeviceName = '';
  sLMDSysPrinterPropTitleDriver = 'Driver';
    sLMDSysPrinterPropDescDriver = '';
  sLMDSysPrinterPropTitleComment = 'Comment';
    sLMDSysPrinterPropDescComment = '';
  sLMDSysPrinterPropTitleLocation = 'Location';
    sLMDSysPrinterPropDescLocation = '';
  sLMDSysPrinterPropTitlePort = 'Port';
    sLMDSysPrinterPropDescPort = '';
  sLMDSysPrinterPropTitleServer = 'Server';
    sLMDSysPrinterPropDescServer = '';
  sLMDSysPrinterPropTitleDataType = 'DataType';
    sLMDSysPrinterPropDescDataType = '';
  sLMDSysPrinterPropTitlePrintProcessor = 'Processor';
    sLMDSysPrinterPropDescPrintProcessor = '';
  sLMDSysPrinterPropTitlePrintProcessorParams = 'PrintProcessorParams';
    sLMDSysPrinterPropDescPrintProcessorParams = '';
  sLMDSysPrinterPropTitleSepFile = 'SepFile';
    sLMDSysPrinterPropDescSepFile = '';
  sLMDSysPrinterPropTitleStartTime = 'StartTime';
    sLMDSysPrinterPropDescStartTime = '';
  sLMDSysPrinterPropTitleUntilTime = 'UntilTime';
    sLMDSysPrinterPropDescUntilTime = '';
  sLMDSysPrinterPropTitleDriverVersion = 'DriverVersion';
    sLMDSysPrinterPropDescDriverVersion = '';
  sLMDSysPrinterPropTitleDuplex = 'Duplex';
    sLMDSysPrinterPropDescDuplex = '';
  sLMDSysPrinterPropTitleOrientation = 'Orientation';
    sLMDSysPrinterPropDescOrientation = '';
  sLMDSysPrinterPropTitlePaperSize = 'PaperSize';
    sLMDSysPrinterPropDescPaperSize = '';
  sLMDSysPrinterPropTitleQuality = 'Quality';
    sLMDSysPrinterPropDescQuality = '';
  sLMDSysPrinterPropTitleScale = 'Scale';
    sLMDSysPrinterPropDescScale = '';
  sLMDSysPrinterPropTitleCopies = 'Copies';
    sLMDSysPrinterPropDescCopies = '';
  sLMDSysPrinterPropTitleTrueTypeOption = 'TrueTypeOption';
    sLMDSysPrinterPropDescTrueTypeOption = '';
  sLMDSysPrinterPropTitleCollate = 'Collate';
    sLMDSysPrinterPropDescCollate = '';
  sLMDSysPrinterPropTitleCustomXRes = 'CustomXRes';
    sLMDSysPrinterPropDescCustomXRes = '';
  sLMDSysPrinterPropTitleCustomYRes = 'CustomYRes';
    sLMDSysPrinterPropDescCustomYRes = '';
  sLMDSysPrinterPropTitlePaperLength = 'PaperLength';
    sLMDSysPrinterPropDescPaperLength = '';
  sLMDSysPrinterPropTitlePaperWidth = 'PaperWidth';
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
  sLMDSysPrinterOrientationLandscape = 'Landscape';
  sLMDSysPrinterQualityHigh = 'High';
  sLMDSysPrinterQualityMedium = 'Medium';
  sLMDSysPrinterQualityLow = 'Low';
  sLMDSysPrinterQualityDraft = 'Draft';
  sLMDSysPrinterQualityCustom = 'Custom';

  sLMDSysPrinterPaperSizeCustom = 'Custom';
  sLMDSysPrinterPaperSizeLETTER = 'Letter, 8 1/2- by 11-inches';
  sLMDSysPrinterPaperSizeLEGAL = 'Legal, 8 1/2- by 14-inches';
  sLMDSysPrinterPaperSizeA4 = 'A4 Sheet, 210- by 297-millimeters';
  sLMDSysPrinterPaperSizeCSHEET = 'C Sheet, 17- by 22-inches';
  sLMDSysPrinterPaperSizeDSHEET = 'D Sheet, 22- by 34-inches';
  sLMDSysPrinterPaperSizeESHEET = 'E Sheet, 34- by 44-inches';
  sLMDSysPrinterPaperSizeLETTERSMALL = 'Letter Small, 8 1/2- by 11-inches';
  sLMDSysPrinterPaperSizeTABLOID = 'Tabloid, 11- by 17-inches';
  sLMDSysPrinterPaperSizeLEDGER = 'Ledger, 17- by 11-inches';
  sLMDSysPrinterPaperSizeSTATEMENT = 'Statement, 5 1/2- by 8 1/2-inches';
  sLMDSysPrinterPaperSizeEXECUTIVE = 'Executive, 7 1/4- by 10 1/2-inches';
  sLMDSysPrinterPaperSizeA3 = 'A3 sheet, 297- by 420-millimeters';
  sLMDSysPrinterPaperSizeA4SMALL = 'A4 small sheet, 210- by 297-millimeters';
  sLMDSysPrinterPaperSizeA5 = 'A5 sheet, 148- by 210-millimeters';
  sLMDSysPrinterPaperSizeB4 = 'B4 sheet, 250- by 354-millimeters';
  sLMDSysPrinterPaperSizeB5 = 'B5 sheet, 182- by 257-millimeter paper';
  sLMDSysPrinterPaperSizeFOLIO = 'Folio, 8 1/2- by 13-inch paper';
  sLMDSysPrinterPaperSizeQUARTO = 'Quarto, 215- by 275-millimeter paper';
  sLMDSysPrinterPaperSize10X14 = '10- by 14-inch sheet';
  sLMDSysPrinterPaperSize11X17 = '11- by 17-inch sheet';
  sLMDSysPrinterPaperSizeNOTE = 'Note, 8 1/2- by 11-inches';
  sLMDSysPrinterPaperSizeENV_9 = '#9 Envelope, 3 7/8- by 8 7/8-inches';
  sLMDSysPrinterPaperSizeENV_10 = '#10 Envelope, 4 1/8- by 9 1/2-inches';
  sLMDSysPrinterPaperSizeENV_11 = '#11 Envelope, 4 1/2- by 10 3/8-inches';
  sLMDSysPrinterPaperSizeENV_12 = '#12 Envelope, 4 3/4- by 11-inches';
  sLMDSysPrinterPaperSizeENV_14 = '#14 Envelope, 5- by 11 1/2-inches';
  sLMDSysPrinterPaperSizeENV_DL = 'DL Envelope, 110- by 220-millimeters';
  sLMDSysPrinterPaperSizeENV_C5 = 'C5 Envelope, 162- by 229-millimeters';
  sLMDSysPrinterPaperSizeENV_C3 = 'C3 Envelope,  324- by 458-millimeters';
  sLMDSysPrinterPaperSizeENV_C4 = 'C4 Envelope,  229- by 324-millimeters';
  sLMDSysPrinterPaperSizeENV_C6 = 'C6 Envelope,  114- by 162-millimeters';
  sLMDSysPrinterPaperSizeENV_C65 = 'C65 Envelope, 114- by 229-millimeters';
  sLMDSysPrinterPaperSizeENV_B4 = 'B4 Envelope,  250- by 353-millimeters';
  sLMDSysPrinterPaperSizeENV_B5 = 'B5 Envelope,  176- by 250-millimeters';
  sLMDSysPrinterPaperSizeENV_B6 = 'B6 Envelope,  176- by 125-millimeters';
  sLMDSysPrinterPaperSizeENV_ITALY = 'Italy Envelope, 110- by 230-millimeters';
  sLMDSysPrinterPaperSizeENV_MONARCH = 'Monarch Envelope, 3 7/8- by 7 1/2-inches';
  sLMDSysPrinterPaperSizeENV_PERSONAL = '6 3/4 Envelope, 3 5/8- by 6 1/2-inches';
  sLMDSysPrinterPaperSizeFANFOLD_US = 'US Std Fanfold, 14 7/8- by 11-inches';
  sLMDSysPrinterPaperSizeFANFOLD_STD_GERMAN = 'German Std Fanfold, 8 1/2- by 12-inches';
  sLMDSysPrinterPaperSizeFANFOLD_LGL_GERMAN = 'German Legal Fanfold, 8 1/2- by 13-inches';
  sLMDSysPrinterOptionBitmap = 'Bitmap';
  sLMDSysPrinterOptionDownload = 'Download';
  sLMDSysPrinterOptionSubDev = 'SubDev';

  sLMDSysPrinterValidFlagORIENTATION = 'ORIENTATION';
  sLMDSysPrinterValidFlagPAPERSIZE = 'PAPERSIZE';
  sLMDSysPrinterValidFlagPAPERLENGTH = 'PAPERLENGTH';
  sLMDSysPrinterValidFlagPAPERWIDTH = 'PAPERWIDTH';
  sLMDSysPrinterValidFlagSCALE = 'SCALE';
  sLMDSysPrinterValidFlagCOPIES = 'COPIES';
  sLMDSysPrinterValidFlagPRINTQUALITY = 'PRINTQUALITY';
  sLMDSysPrinterValidFlagCOLOR = 'COLOR';
  sLMDSysPrinterValidFlagDUPLEX = 'DUPLEX';
  sLMDSysPrinterValidFlagYRESOLUTION = 'YRESOLUTION';
  sLMDSysPrinterValidFlagTTOPTION = 'TRUETYPEOPTION';
  sLMDSysPrinterValidFlagCOLLATE = 'COLLATE';

  // TLMDSysWindowsObject Display Strings
  // -------------------------------------
  sLMDSysWindowsObjectsTitle = 'Windows';
    sLMDSysWindowsObjectsDesc = '';
  sLMDSysWinPropTitleRegisteredOwner = 'Registered Owner';
    sLMDSysWinPropDescRegisteredOwner = '';
  sLMDSysWinPropTitleRegisteredCompany = 'Registered Company';
    sLMDSysWinPropDescRegisteredCompany = '';
  sLMDSysWinPropTitleProductName = 'Product Name';
    sLMDSysWinPropDescProductName = '';
  sLMDSysWinPropTitleProductID = 'Product ID';
    sLMDSysWinPropDescProductID = '';
  sLMDSysWinPropTitleProductType = 'Product Type';
    sLMDSysWinPropDescProductType = '';
  sLMDSysWinPropTitleProductSuite = 'Product Suit Ident';
    sLMDSysWinPropDescProductSuite = '';
  sLMDSysWinPropTitleProductVersion = 'Product Version';
    sLMDSysWinPropDescProductVersion = '';
  sLMDSysWinPropTitleVersionName = 'Version Name';
    sLMDSysWinPropDescVersionName = '';
  sLMDSysWinPropTitleServicePackMajor = 'Service Pack Major Version';
    sLMDSysWinPropDescServicePackMajor = '';
  sLMDSysWinPropTitleServicePackMinor = 'Service Pack Minor Version';
    sLMDSysWinPropDescServicePackMinor = '';
  sLMDSysWinPropTitleUpTimeString = 'Up Time';
    sLMDSysWinPropDescUpTimeString = '';
  sLMDSysWinPropTitleLastBoot = 'Last Boot';
    sLMDSysWinPropDescLastBoot = '';
  sLMDSysWinPropTitleSystemFolders = 'System Folders';
    sLMDSysWinPropDescSystemFolders = '';
  sLMDSysWinPropTitleWinDir = 'Windows Directory';
    sLMDSysWinPropDescWinDir = '';
  sLMDSysWinPropTitleSysDir = 'System Directory';
    sLMDSysWinPropDescSysDir = '';
  sLMDSysWinPropTitleTempDir = 'Temp Directory';
    sLMDSysWinPropDescTempDir = '';
  sLMDSysWinPropTitleEnvironment = 'Environment';
    sLMDSysWinPropDescEnvironment = '';
  sLMDSysWinPropTitleInstallDate = 'Install Date';
    sLMDSysWinPropDescInstallDate = '';
  sLMDSysWinPropTitleCSDVersion = 'CSDVersion';
    sLMDSysWinPropDescCSDVersion = '';
  sLMDSysWinPropTitlePlatformID = 'Platform ID';
    sLMDSysWinPropDescPlatformID = '';
  sLMDSysWinPropTitleBuildNumber = 'Build Number';
    sLMDSysWinPropDescBuildNumber = '';
  sLMDSysWinPropTitleMajorVersion = 'Major Version';
    sLMDSysWinPropDescMajorVersion = '';
  sLMDSysWinPropTitleMinorVersion = 'Minor Version';
    sLMDSysWinPropDescMinorVersion = '';

    //KEYBOARD SECTION
  sLMDSysKeyboardObjectsTitle = 'Keyboard';
    sLMDSysKeyboardObjectsDesc = '';

  sLMDKeyboard1 ='IBM PC/XT or compatible (83-key) keyboard';
  sLMDKeyboard2 ='Olivetti "ICO" (102-key) keyboard';
  sLMDKeyboard3 ='IBM PC/AT (84-key) or similar keyboard';
  sLMDKeyboard4 ='IBM enhanced (101- or 102-key) keyboard';
  sLMDKeyboard5 ='Nokia 1050 and similar keyboards';
  sLMDKeyboard6 ='Nokia 9140 and similar keyboards';
  sLMDKeyboard7 ='Japanese keyboard';

  sLMDSysKeyboardPropTitleDelay = 'Delay';
    sLMDSysKeyboardPropDescDelay = '';
  sLMDSysKeyboardPropTitleSpeed = 'Speed';
    sLMDSysKeyboardPropDescSpeed = '';
  sLMDSysKeyboardPropTitleNumLock = 'NumLock';
    sLMDSysKeyboardPropDescNumLock = '';
  sLMDSysKeyboardPropTitleCapsLock = 'CapsLock';
    sLMDSysKeyboardPropDescCapsLock = '';
  sLMDSysKeyboardPropTitleCaretBlinkTime = 'CaretBlinkTime';
    sLMDSysKeyboardPropDescCaretBlinkTime = '';
  sLMDSysKeyboardPropTitleScrollLock = 'ScrollLock';
    sLMDSysKeyboardPropDescScrollLock = '';
  sLMDSysKeyboardPropTitleTypeString = 'KeyboardType';
    sLMDSysKeyboardPropDescTypeString = '';
  sLMDSysKeyboardPropTitleType = 'TypeID';
    sLMDSysKeyboardPropDescType = '';
  sLMDSysKeyboardPropTitleSubType = 'SubTypeID';
    sLMDSysKeyboardPropDescSubType = '';
  sLMDSysKeyboardPropTitleFunctionKeys = 'FunctionKeys';
    sLMDSysKeyboardPropDescFunctionKeys = '';
  sLMDSysKeyboardPropTitleLayout = 'Layout';
    sLMDSysKeyboardPropDescLayout = '';

  // MEMORY Display Strings
  // ----------------------
  sLMDSysMemoryObjectsTitle = 'Memory';
    sLMDSysMemoryObjectsDesc = '';

  sLMDSysMemoryPropTitleMemoryLoad = 'MemoryLoad';
    sLMDSysMemoryPropDescMemoryLoad = '';
  sLMDSysMemoryPropTitleTotalPhysicalMemory = 'TotalPhysicalMemory';
    sLMDSysMemoryPropDescTotalPhysicalMemory = '';
  sLMDSysMemoryPropTitleAvailablePhysicalMemory = 'AvailablePhysicalMemory';
    sLMDSysMemoryPropDescAvailablePhysicalMemory = '';
  sLMDSysMemoryPropTitleTotalPageFile = 'TotalPageFile';
    sLMDSysMemoryPropDescTotalPageFile = '';
  sLMDSysMemoryPropTitleAvailablePageFile = 'AvailablePageFile';
    sLMDSysMemoryPropDescAvailablePageFile = '';
  sLMDSysMemoryPropTitleTotalVirtual = 'TotalVirtual';
    sLMDSysMemoryPropDescTotalVirtual = '';
  sLMDSysMemoryPropTitleAvailableVirtual = 'AvailableVirtual';
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
  sLMDSysProcessorObjectsTitle = 'Processor';
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
  sLMDSysProcessorPropTitleProcessorUsage = 'ProcessorUsage';
    sLMDSysProcessorPropDescProcessorUsage = '';
  sLMDSysProcessorPropTitleIDString = 'IDString';
    sLMDSysProcessorPropDescIDString = '';
  sLMDSysProcessorPropTitleCPUName = 'CPUName';
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
  sLMDSysPowerStatusObjectsTitle = 'Power Status';
    sLMDSysPowerStatusObjectsDesc = '';

  sLMDSysPowerStatusPropTitleACLineStatus = 'ACLineStatus';
    sLMDSysPowerStatusPropDescACLineStatus = '';
  sLMDSysPowerStatusPropTitleBatteryFlags = 'BatteryFlags';
    sLMDSysPowerStatusPropDescBatteryFlags = '';
  sLMDSysPowerStatusPropTitleBatteryLifePercent = 'BatteryLifePercent';
    sLMDSysPowerStatusPropDescBatteryLifePercent = '';
  sLMDSysPowerStatusPropTitleBatteryLifeTime = 'BatteryLifeTime';
    sLMDSysPowerStatusPropDescBatteryLifeTime = '';
  sLMDSysPowerStatusPropTitleBatteryFullLifeTime = 'BatteryFullLifeTime';
    sLMDSysPowerStatusPropDescBatteryFullLifeTime = '';
  sACLineStatusOffline = 'Offline';
  sACLineStatusOnline = 'Online';
  sACLineStatusUnknown = 'Unknown';
  sBatteryFlagHigh = 'High';
  sBatteryFlagLow = 'Low';
  sBatteryFlagCritical = 'Critical';
  sBatteryFlagCharging = 'Charging';
  sBatteryFlagNoSystemBat = 'No System Battery';
  sBatteryFlagUnkown = 'Unkown';

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
  sLMDSysLocaleObjectsTitle = 'Locale';
    sLMDSysLocaleObjectsDesc = '';

  sLMDSysLocalePropTitleCalendarType = 'CalendarType';
    sLMDSysLocalePropDescCalendarType = '';
  sLMDSysLocalePropTitleCurrencyDigits = 'CurrencyDigits';
    sLMDSysLocalePropDescCurrencyDigits = '';
  sLMDSysLocalePropTitlePositiveCurrencyFormat = 'PositiveCurrencyFormat';
    sLMDSysLocalePropDescPositiveCurrencyFormat = '';
  sLMDSysLocalePropTitleDigits = 'Digits';
    sLMDSysLocalePropDescDigits = '';
  sLMDSysLocalePropTitleFirstDayOfWeek = 'FirstDayOfWeek';
    sLMDSysLocalePropDescFirstDayOfWeek = '';
  sLMDSysLocalePropTitleFirstWeekOfYear = 'FirstWeekOfYear';
    sLMDSysLocalePropDescFirstWeekOfYear = '';
  sLMDSysLocalePropTitleShowLeadingZero = 'ShowLeadingZero';
    sLMDSysLocalePropDescShowLeadingZero = '';
  sLMDSysLocalePropTitleMeasurement = 'Measurement';
    sLMDSysLocalePropDescMeasurement = '';
  sLMDSysLocalePropTitleNegativeCurrencyFormat = 'NegativeCurrencyFormat';
    sLMDSysLocalePropDescNegativeCurrencyFormat = '';
  sLMDSysLocalePropTitleNegativeFormat = 'NegativeFormat';
    sLMDSysLocalePropDescNegativeFormat = '';
  sLMDSysLocalePropTitleClockMode = 'ClockMode';
    sLMDSysLocalePropDescClockMode = '';
  sLMDSysLocalePropTitleMorningSymbol = 'MorningSymbol';
    sLMDSysLocalePropDescMorningSymbol = '';
  sLMDSysLocalePropTitleAfternoonSymbol = 'AfternoonSymbol';
    sLMDSysLocalePropDescAfternoonSymbol = '';
  sLMDSysLocalePropTitleCurrencySymbol = 'CurrencySymbol';
    sLMDSysLocalePropDescCurrencySymbol = '';
  sLMDSysLocalePropTitleDateSeparator = 'DateSeparator';
    sLMDSysLocalePropDescDateSeparator = '';
  sLMDSysLocalePropTitleDecimalSeparator = 'DecimalSeparator';
    sLMDSysLocalePropDescDecimalSeparator = '';
  sLMDSysLocalePropTitleGrouping = 'Grouping';
    sLMDSysLocalePropDescGrouping = '';
  sLMDSysLocalePropTitleListSeparator = 'ListSeparator';
    sLMDSysLocalePropDescListSeparator = '';
  sLMDSysLocalePropTitleLongDateFormat = 'LongDateFormat';
    sLMDSysLocalePropDescLongDateFormat = '';
  sLMDSysLocalePropTitleCurrencyDecimalSeparator = 'CurrencyDecimalSeparator';
    sLMDSysLocalePropDescCurrencyDecimalSeparator = '';
  sLMDSysLocalePropTitleCurrencyGrouping = 'CurrencyGrouping';
    sLMDSysLocalePropDescCurrencyGrouping = '';
  sLMDSysLocalePropTitleCurrencyGroupingSign = 'CurrencyThousandSeparator';
    sLMDSysLocalePropDescCurrencyGroupingSign = '';
  sLMDSysLocalePropTitleNegativeSign = 'NegativeSign';
    sLMDSysLocalePropDescNegativeSign = '';
  sLMDSysLocalePropTitlePositiveSign = 'PositiveSign';
    sLMDSysLocalePropDescPositiveSign = '';
  sLMDSysLocalePropTitleShortDateFormat = 'ShortDateFormat';
    sLMDSysLocalePropDescShortDateFormat = '';
  sLMDSysLocalePropTitleThousandSeparator = 'ThousandSeparator';
    sLMDSysLocalePropDescThousandSeparator = '';
  sLMDSysLocalePropTitleTimeSeparator = 'TimeSeparator';
    sLMDSysLocalePropDescTimeSeparator = '';
  sLMDSysLocalePropTitleTimeFormat = 'TimeFormat';
    sLMDSysLocalePropDescTimeFormat = '';
  sLMDSysLocalePropTitleShortDateOrder = 'ShortDateOrder';
    sLMDSysLocalePropDescShortDateOrder = '';
  sLMDSysLocalePropTitleLongDateOrder = 'LongDateOrder';
    sLMDSysLocalePropDescLongDateOrder = '';
  sLMDSysLocalePropTitleYearDigits = 'YearDigits';
    sLMDSysLocalePropDescYearDigits = '';
  sLMDSysLocalePropTitleInternationalCurrencySymbol = 'InternationalCurrencySymbol';
    sLMDSysLocalePropDescInternationalCurrencySymbol = '';
  sLMDSysLocalePropTitleLanguage = 'Language';
    sLMDSysLocalePropDescLanguage = '';
  sLMDSysLocalePropTitleLanguageEnglish = 'LanguageEnglish';
    sLMDSysLocalePropDescLanguageEnglish = '';
  sLMDSysLocalePropTitleLanguageSymbol = 'LanguageSymbol';
    sLMDSysLocalePropDescLanguageSymbol = '';
  sLMDSysLocalePropTitleCountryCode = 'CountryCode';
    sLMDSysLocalePropDescCountryCode = '';
  sLMDSysLocalePropTitleCountry = 'Country';
    sLMDSysLocalePropDescCountry = '';
  sLMDSysLocalePropTitleCountrySymbol = 'CountrySymbol';
    sLMDSysLocalePropDescCountrySymbol = '';

  // UNINSTALL SECTION
  sLMDSysUninstallGroupTitle = 'Uninstall';
    sLMDSysUninstallGroupDesc = '';

  sLMDSysUninstallPropTitleProgramName = 'ProgramName';
    sLMDSysUninstallPropDescProgramName = '';
  sLMDSysUninstallPropTitleUninstallPath = 'UninstallPath';
    sLMDSysUninstallPropDescUninstallPath = '';
  sLMDSysUninstallPropTitlePublisher = 'Publisher';
    sLMDSysUninstallPropDescPublisher = '';
  sLMDSysUninstallPropTitlePublisherURL = 'PublisherURL';
    sLMDSysUninstallPropDescPublisherURL = '';
  sLMDSysUninstallPropTitleVersion = 'Version';
    sLMDSysUninstallPropDescVersion = '';
  sLMDSysUninstallPropTitleHelpLink = 'HelpLink';
    sLMDSysUninstallPropDescHelpLink = '';
  sLMDSysUninstallPropTitleUpdateInfoURL = 'UpdateInfoURL';
    sLMDSysUninstallPropDescUpdateInfoURL = '';
  sLMDSysUninstallPropTitleRegCompany = 'RegCompany';
    sLMDSysUninstallPropDescRegCompany = '';
  sLMDSysUninstallPropTitleRegOwner = 'RegOwner';
    sLMDSysUninstallPropDescRegOwner = '';

  // FONTS SECTION
  sLMDSysFontGroupTitle = 'Font';
    sLMDSysFontGroupDesc = '';

  sLMDSysFontPropTitleFontType = 'FontType';
    sLMDSysFontPropDescFontType = '';
  sLMDSysFontPropTitleFullName = 'FullName';
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

  sCharSetANSI_CHARSET  = 'ANSI characters';
  sCharSetDEFAULT_CHARSET = 'Font is chosen based solely on Name and Size. If the described font is not available on the system, Windows will substitute another font';
  sCharSetSYMBOL_CHARSET =  'Standard symbol set';
  sCharSetMAC_CHARSET = 'Macintosh characters. Not available on NT 3.51';
  sCharSetSHIFTJIS_CHARSET = 'Japanese shift-jis characters';
  sCharSetHANGEUL_CHARSET = 'Korean characters (Wansung)';
  sCharSetJOHAB_CHARSET = 'Korean characters (Johab). Not available on NT 3.51';
  sCharSetGB2312_CHARSET = 'Simplified Chinese characters (mainland china)';
  sCharSetCHINESEBIG5_CHARSET = 'Traditional Chinese characters (taiwanese)';
  sCharSetGREEK_CHARSET = 'Greek characters. Not available on NT 3.51';
  sCharSetTURKISH_CHARSET = 'Turkish characters. Not available on NT 3.51';
  sCharSetVIETNAMESE_CHARSET = 'Vietnamese characters. Not available on NT 3.51';
  sCharSetHEBREW_CHARSET = 'Hebrew characters. Not available on NT 3.51';
  sCharSetARABIC_CHARSET = 'Arabic characters. Not available on NT 3.51';
  sCharSetBALTIC_CHARSET = 'Baltic characters. Not available on NT 3.51';
  sCharSetRUSSIAN_CHARSET = 'Cyrillic characters. Not available on NT 3.51';
  sCharSetTHAI_CHARSET = 'Thai characters. Not available on NT 3.51';
  sCharSetEASTEUROPE_CHARSET = 'Includes diacritical marks for eastern european countries. Not available on NT 3.51';
  sCharSetOEM_CHARSET = 'Depends on the codepage of the operating system';

  sFontPitchDefault = 'Default';
  sFontPitchVariable = 'Variable';
  sFontPitchFixed = 'Fixed';

  sTM_ITALIC = 'ITALIC';
  sTM_BOLD = 'BOLD';
  sTM_REGULAR = 'REGULAR';
  sTM_NONNEGATIVE_AC = 'NONNEGATIVE_AC';
  sTM_PS_OPENTYPE = 'PS_OPENTYPE';
  sTM_TT_OPENTYPE = 'TT_OPENTYPE';
  sTM_MULTIPLEMASTER = 'MULTIPLEMASTER';
  sTM_TYPE1 = 'TYPE1';
  sTM_DSIG = 'DSIG';

  // MULTIMEDIA SECTION
  sLMDSysMultimediaGroupTitle = 'Multimedia';
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


  sLMDSysMultimediaCmnPropTitleDeviceID = 'DeviceID';
    sLMDSysMultimediaCmnPropDescDeviceID = '';
  sLMDSysMultimediaCmnPropTitleManufacturerID = 'ManufacturerID';
    sLMDSysMultimediaCmnPropDescManufacturerID = '';
  sLMDSysMultimediaCmnPropTitleProductID = 'ProductID';
    sLMDSysMultimediaCmnPropDescProductID = '';
  sLMDSysMultimediaCmnPropTitleMajorVer = 'MajorVer';
    sLMDSysMultimediaCmnPropDescMajorVer = '';
  sLMDSysMultimediaCmnPropTitleMinorVer = 'MinorVer';
    sLMDSysMultimediaCmnPropDescMinorVer = '';
  sLMDSysMultimediaCmnPropTitleName = 'Name';
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

  sLMDSysmidiOutAudioPropTitleTechnology = 'Technology';
    sLMDSysmidiOutAudioPropDescTechnology = '';
  sLMDSysmidiOutAudioPropTitleVoices = 'Voices';
    sLMDSysmidiOutAudioPropDescVoices = '';
  sLMDSysmidiOutAudioPropTitleNotes = 'Notes';
    sLMDSysmidiOutAudioPropDescNotes = '';
  sLMDSysmidiOutAudioPropTitleChannelMask = 'ChannelMask';
    sLMDSysmidiOutAudioPropDescChannelMask = '';
  sLMDSysmidiOutAudioPropTitleSupport = 'Support';
    sLMDSysmidiOutAudioPropDescSupport = '';

  sLMDMIDITechnologyMIDIPORT = 'The device is a MIDI hardware port';
  sLMDMIDITechnologySYNTH = 'The device is a synthesizer';
  sLMDMIDITechnologySQSYNTH = 'The device is a square wave synthesizer';
  sLMDMIDITechnologyFMSYNTH = 'The device is an FM synthesizer';
  sLMDMIDITechnologyMAPPER = 'The device is the Microsoft MIDI mapper';
  sLMDMIDITechnologyWAVETABLE = 'The device is a hardware wavetable synthesizer';
  sLMDMIDITechnologySWSYNTH = 'The device is a software synthesizer';

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
  sLMDMIDIOutSupportLRVOLUME = 'LRVOLUME';
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

  sLMDWaveOutSupportLRVOLUME = 'LRVOLUME';
  sLMDWaveOutSupportVOLUME = 'VOLUME';
  sLMDWaveOutSupportPITCH = 'PITCH';
  sLMDWaveOutSupportPLAYBACKRATE = 'PLAYBACKRATE';
  sLMDWaveOutSupportSYNC = 'SYNC';
  sLMDWaveOutSupportSAMPLEACCURATE = 'SAMPLEACCURATE';


  sLMDSysVolumPropTitleVolumeL = 'VolumeL';
    sLMDSysVolumPropDescVolumeL = '';
  sLMDSysVolumPropTitleVolumeR = 'VolumeR';
    sLMDSysVolumPropDescVolumeR = '';
  sLMDSysDauxAudioPropTitledauxTechnology = 'dauxTechnology';
    sLMDSysDauxAudioPropDescdauxTechnology = '';
  sLMDSysDauxAudioPropTitledauxSupport = 'dauxSupport';
    sLMDSysDauxAudioPropDescdauxSupport = '';

  sLMDDauxSupportNone = 'None';
  sLMDDauxSupportVolume = 'Volume';
  sLMDDauxSupportLRVolume = 'LRVolume';

  sLMDDauxTechNone = 'None';
  sLMDDauxTechAUXIN = 'AUXIN';
  sLMDDauxTechCDAUDIO = 'CDAUDIO';

  sLMDSysMixerPropTitleDestinations = 'Destinations';
    sLMDSysMixerPropDescDestinations = '';

  // File assoc section
  sLMDSysFileActionTitle = 'File Action';
    sLMDSysFileActionDesc = '';
  sLMDSysFileActionGroupTitle = 'File Actions';
    sLMDSysFileActionGroupDesc = '';
  sLMDSysFileAssocTitle = 'File Association';
    sLMDSysFileAssocDesc = '';
  sLMDSysFileAssocGroupTitle = 'File Associations';
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
  sLMDSysInetPropTitleBrowser='Browser';
    sLMDSysInetPropDescBrowser='';
  sLMDSysInetAdvPropGroupTitle = 'Advanced properties';
    sLMDSysInetAdvPropGroupDesc = '';
  sLMDSysInetAdvPropTitle = 'Advanced property';
    sLMDSysInetAdvPropDesc = '';
  sLMDSysInetZoneGroupTitle = 'Internet Zones';
    sLMDSysInetZoneGroupDesc = '';
  sLMDSysInetZoneTitle = 'Internet Zone';
    sLMDSysInetZoneDesc = '';
//  sLMDSysTempInternetFilesTitle = 'Temp Internet Files';
//    sLMDSysTempInternetFilesDesc = '';
  sLMDSysInternetTitle = 'Internet';
    sLMDSysInternetDesc = '';

  sLMDSysInetPropTitleName = 'Name';
    sLMDSysInetPropDescName = '';
  sLMDSysInetPropTitleValue = 'Value';
    sLMDSysInetPropDescValue = '';
  sLMDSysInetPropTitleZoneName = 'ZoneName';
    sLMDSysInetPropDescZoneName = '';
  sLMDSysInetPropTitleZoneDescription = 'ZoneDescription';
    sLMDSysInetPropDescZoneDescription = '';
  sLMDSysInetPropTitleZoneSites = 'ZoneSites';
    sLMDSysInetPropDescZoneSites = '';
  sLMDSysInetPropTitlePath = 'TempPath';
    sLMDSysInetPropDescPath = '';
  sLMDSysInetPropTitleMaxSize = 'TmpMaxSize';
    sLMDSysInetPropDescMaxSize = '';
  sLMDSysInetPropTitleHomePage = 'HomePage';
    sLMDSysInetPropDescHomePage = '';
  sLMDSysInetPropTitleHTMLEditor = 'HTMLEditor';
    sLMDSysInetPropDescHTMLEditor = '';
  sLMDSysInetPropTitleEMailClient = 'EMailClient';
    sLMDSysInetPropDescEMailClient = '';
  sLMDSysInetPropTitleNewsClient = 'NewsClient';
    sLMDSysInetPropDescNewsClient = '';
  sLMDSysInetPropTitleCalendar = 'Calendar';
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

  sLMDSysModemTitleName = 'Name';
    sLMDSysModemDescName = '';
  sLMDSysModemTitleAttachedTo = 'AttachedTo';
    sLMDSysModemDescAttachedTo = '';
  sLMDSysModemTitleUserInit = 'UserInit';
    sLMDSysModemDescUserInit = '';
  sLMDSysModemTitlePortSpeed = 'PortSpeed';
    sLMDSysModemDescPortSpeed = '';

  // Network section
  sLMDSysNetServiceNameTitle = 'ServiceName';
    sLMDSysNetServiceNameDesc = '';
  sLMDSysNetDescriptionTitle = 'Description';
    sLMDSysNetDescriptionDesc = '';

  sLMDSysNetUserNameTitle = 'Username';
    sLMDSysNetUserNameDesc = '';
  sLMDSysNetComputerNameTitle = 'ComputerName';
    sLMDSysNetComputerNameDesc = '';


  sLMDSysTCPIPTitle = 'TCP/IP';
    sLMDSysTCPIPDesc = '';
  sLMDSysIPXTitle = 'IPX';
    sLMDSysIPXDesc = '';
  sLMDSysNetBEUITitle = 'NetBEUI';
    sLMDSysNetBEUIDesc = '';
  sLMDSysNetworkTitle = 'Network';
    sLMDSysNetworkDesc = '';
  sLMDSysNetworkCardTitle = 'Network card';
    sLMDSysNetworkCardDesc = '';
  sLMDSysNetworkCardGroupTitle = 'Network cards';
    sLMDSysNetworkCardGroupDesc = '';


  sLMDSysProtocolPropTitleInstalled = 'Installed';
    sLMDSysProtocolPropDescInstalled = '';
  sLMDSysTCPIPPropTitleIPAddress = 'IPAddress';
    sLMDSysTCPIPPropDescIPAddress = '';
  sLMDSysTCPIPPropTitleIPSubnetMask = 'IPSubnetMask';
    sLMDSysTCPIPPropDescIPSubnetMask = '';
  sLMDSysTCPIPPropTitleDefaultGateway = 'DefaultGateway';
    sLMDSysTCPIPPropDescDefaultGateway = '';
  sLMDSysIPXPropTitleNetworkNumber = 'NetworkNumber';
    sLMDSysIPXPropDescNetworkNumber = '';
  sLMDSysTCPIPPropTitleDHCPEnabled= 'DHCPEnabled';
    sLMDSysTCPIPPropDescDHCPEnabled= '';


  //WMI common properties

  sLMDSysAvailabilityUnDefined = 'UnDefined';
  sLMDSysAvailabilityOther = 'Other';
  sLMDSysAvailabilityUnknown = 'Unknown';
  sLMDSysAvailabilityRunning = 'Running';
  sLMDSysAvailabilityWarning = 'Warning';
  sLMDSysAvailabilityInTest = 'InTest';
  sLMDSysAvailabilityNotApplicable = 'NotApplicable';
  sLMDSysAvailabilityPowerOff = 'PowerOff';
  sLMDSysAvailabilityOffLine = 'OffLine';
  sLMDSysAvailabilityOffDuty = 'OffDuty';
  sLMDSysAvailabilityDegraded = 'Degraded';
  sLMDSysAvailabilityNotInstalled = 'NotInstalled';
  sLMDSysAvailabilityInstallError = 'InstallError';
  sLMDSysAvailabilityPowerSaveUnknown = 'PowerSaveUnknown';
  sLMDSysAvailabilityPowerSaveLowPowerMode = 'PowerSaveLowPowerMode';
  sLMDSysAvailabilityPowerSaveStandby = 'PowerSaveStandby';
  sLMDSysAvailabilityPowerCycle = 'PowerCycle';
  sLMDSysAvailabilityPowerSaveWarning = 'PowerSaveWarning';

  sLMDSysPMCpmUnknown = 'Unknown';
  sLMDSysPMCpmNotSupported = 'NotSupported';
  sLMDSysPMCpmDisabled = 'Disabled';
  sLMDSysPMCpmEnabled = 'Enabled';
  sLMDSysPMCpmPowerSavingModesEnteredAutomatically = 'PowerSavingModesEnteredAutomatically';
  sLMDSysPMCpmPowerStateSettable = 'PowerStateSettable';
  sLMDSysPMCpmPowerCyclingSupported = 'PowerCyclingSupported';
  sLMDSysPMCpmTimedPowerOnSupported = 'TimedPowerOnSupported';

  sLMDSysSIUndefined = 'Undefined';
  sLMDSysSIOther = 'Other';
  sLMDSysSIUnknown = 'Unknown';
  sLMDSysSIEnabled = 'Enabled';
  sLMDSysSIDisabled = 'Disabled';
  sLMDSysSINotApplicable = 'NotApplicable';

implementation

end.
