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
  strWallpaperTile = 'Display:Wallpaper:Tile';
  strWallpaperStretch = 'Display:Wallpaper:Stretch';
  strWallpaperFileName = 'Display:Wallpaper:FileName';
  strWallpaperPattern = 'Display:Wallpaper:Pattern';

  // ** TLMDSysScreensaverObject ***********************************************
  strScreensaverSecure = 'Display:Screensaver:Secure';
  strScreensaverDelay = 'Display:Screensaver:Delay';
  strScreensaverExeName = 'Display:Screensaver:ExeName';

  // ** TLMDSysPlusObject ******************************************************
  strPlusFontSmoothing = 'Display:Plus:FontSmoothing';
  strPlusWindowAnimation = 'Display:Plus:WindowAnimation';
  strPlusDragFullWindows = 'Display:Plus:DragFullWindows';

  // ** TLMDSysKeyboardObject **************************************************
  strKeyboardSpeed = 'Keyboard:Speed';
  strKeyboardDelay = 'Keyboard:Delay';
  strCaretBlinkTime = 'Keyboard:CaretBlinkTime';

  // ** TLMDSysLocaleObject ****************************************************
  strCalendarType = 'Locale:CalendarType';
  strCurrencyDigits = 'Locale:CurrencyDigits';
  strPositiveCurrencyFormat = 'Locale:PositiveCurrencyFormat';
  strDigits = 'Locale:Digits';
  strFirstDayOfWeek = 'Locale:FirstDayOfWeek';
  strFirstWeekOfYear = 'Locale:FirstWeekOfYear';
  strShowLeadingZero = 'Locale:ShowLeadingZero';
  strMeasurement = 'Locale:Measurement';
  strNegativeCurrencyFormat = 'Locale:NegativeCurrencyFormat';
  strNegativeFormat = 'Locale:NegativeFormat';
  strClockMode = 'Locale:ClockMode';
  strMorningSymbol = 'Locale:MorningSymbol';
  strAfternoonSymbol = 'Locale:AfternoonSymbol';
  strCurrencySymbol = 'Locale:CurrencySymbol';
  strDateSeparator = 'Locale:DateSeparator';
  strDecimalSeparator = 'Locale:DecimalSeparator';
  strGrouping = 'Locale:Grouping';
  strListSeparator = 'Locale:ListSeparator';
  strLongDateFormat = 'Locale:LongDateFormat';
  strCurrencyDecimalSeparator = 'Locale:CurrencyDecimalSeparator';
  strCurrencyGrouping = 'Locale:CurrencyGrouping';
  strCurrencyGroupingSign = 'Locale:CurrencyGroupingSign';
  strNegativeSign = 'Locale:NegativeSign';
  strPositiveSign = 'Locale:PositiveSign';
  strShortDateFormat = 'Locale:ShortDateFormat';
  strThousandSeparator = 'Locale:ThousandSeparator';
  strTimeSeparator = 'Locale:TimeSeparator';
  strTimeFormat = 'Locale:TimeFormat';
  strShortDateOrder = 'Locale:ShortDateOrder';
  strLongDateOrder = 'Locale:LongDateOrder';
  strYearDigits = 'Locale:YearDigits';
  strInternationalCurrencySymbol = 'Locale:InternationalCurrencySymbol';
  strLanguage = 'Locale:Language';
  strLanguageEnglish = 'Locale:LanguageEnglish';
  strLanguageSymbol = 'Locale:LanguageSymbol';
  strCountryCode = 'Locale:CountryCode';
  strCountry = 'Locale:Country';
  strCountrySymbol = 'Locale:CountrySymbol';

  // ** TLMDSysMouseObject *****************************************************
  strDoubleClickTime = 'Mouse:DoubleClickTime';
  strSwapButtons = 'Mouse:SwapButtons';
  strMouseSpeed = 'Mouse:Speed';
  strMouseSnapToDefault = 'Mouse:SnapToDefault';
  strDoubleClickWidth = 'Mouse:DoubleClickWidth';
  strDoubleClickHeight = 'Mouse:DoubleClickHeight';

  // ** TLMDUninstallItem ******************************************************
  strUninstallProgramName = 'Uninstall[%d]:ProgramName';
  strUninstallUninstallPath = 'Uninstall[%d]:UninstallPath';
  strUninstallPublisher = 'Uninstall[%d]:Publisher';
  strUninstallPublisherURL = 'Uninstall[%d]:PublisherURL';
  strUninstallVersion = 'Uninstall[%d]:Version';
  strUninstallHelpLink = 'Uninstall[%d]:HelpLink';
  strUninstallUpdateInfoURL = 'Uninstall[%d]:UpdateInfoURL';
  strUninstallRegCompany = 'Uninstall[%d]:RegCompany';
  strUninstallRegOwner = 'Uninstall[%d]:RegOwner';

  // ** TLMDSysMultimediaObject ************************************************
  strMMauxVolumeL = 'MMedia:aux[%d]:VolumeL';
  strMMauxVolumeR = 'MMedia:aux[%d]:VolumeR';
  strMMwaveVolumeL = 'MMedia:wave[%d]:VolumeL';
  strMMwaveVolumeR = 'MMedia:wave[%d]:VolumeR';
  strMMmidiVolumeL = 'MMedia:midi[%d]:VolumeL';
  strMMmidiVolumeR = 'MMedia:midi[%d]:VolumeR';

  // ** TLMDModemItem **********************************************************
  strModemUserInit = 'Modem:UserInit';

  // ** TLMDSysFileAssoc *******************************************************
  strFileAssocDescription = 'FileAssoc[%d]:Description';
  strFileAssocDefIcon = 'FileAssoc[%d]:DefIconStr';
  strFileAssocActionFile = 'FileAssoc[%d]:Action[%d]:ActionFile';
implementation

end.
