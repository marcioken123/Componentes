unit LMDElConst;
{$I lmdcmps.inc}

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

LMDElConst unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Graphics;

  {$R LMDElPack.res}

resourcestring
  SLMDDay  = 'Day ';
  SLMDWeek = 'Week ';
  SLMDHintNextYear = 'Next year';
  SLMDHintPrevYear = 'Previous year';
  SLMDHintNextMonth = 'Next month';
  SLMDHintPrevMonth = 'Previous month';
  SLMDCapClear      = 'Clear';
  SLMDCapToday      = 'Today';
  SLMDCapOk      = 'OK';
  SLMDCapCancel      = 'Cancel';
  SLMDCapCalendar   = 'Calendar';
  SLMDCapCalendarGB = 'Date';
  SLMDCapClockGB = 'Time';

  SLMDCustom = 'Custom ...';

  SLMDUndo = '&Undo';
  SLMDCut = 'Cu&t';
  SLMDCopy = '&Copy';
  SLMDPaste = '&Paste';
  SLMDDelete = '&Delete';
  SLMDSelectAll = '&Select All';

  SLMDShiftP = 'Shift+';
  SLMDAltP = 'Alt+';
  SLMDCtrlP = 'Ctrl+';
  SLMDLeftP = 'Left+';
  SLMDRightP = 'Right+';
  SLMDMiddleP = 'Middle+';
  SLMDDoubleP = 'Double+';
  SLMDLWinP = 'Win+';
  SLMDRWinP = 'Win+';

  SLMDElCantSetThisEntryAs = 'You can'#39't set this ini entry as %s';
  SLMDElCantGetThisPropAs = 'You can'#39't get this property as %s';
  SLMDElCantSetThisPropAs = 'You can'#39't set this property as %s';

  SLMDListIndexOutOfBounds = 'List index [%d] out of bounds...';

  SLMDBitmapInvalid = 'Bitmap image is not valid';
  SLMDSyntaxError = 'Syntax error';
  SLMDCloseBracketExpected = '")" expected';
  SLMDExpressionEmpty = 'Expression is empty';
  SLMDOpenBracketExpected = '"(" expected';
  SLMDInvalidArgument = 'Invalid argument';
  SLMDMathFunctions = 'Mathematical functions';

  SLMDShowNextTime = 'Show next time';
  SLMDDSecondsLeft = '%d seconds left';

  SElNotIdent = 'This integer hasn'#39't ident';
  SElInstanceIsNotDefined = 'Instance is not defined';
  SElRequiredPropertyIsNotDefined = 'Required property %s is not defined';
  SElCantGetThisPropAs = 'You can'#39't get this property as %s';
  SElCantSetThisPropAs = 'You can'#39't set this property as %s';
  SElIsNotEnum = 'Property %s hasn'#39't enumerate values';
  SElReadonly = 'Property %s is read only';
  SElInvalidType = 'Invalid typecast for %s';
  SElNotFound = '%s %s not found';
  SElCompUnassignedValue = '';
  SElClassUnassignedValue = '';

  SLMDNoControl = 'No scrollbar specified when attempting to create TElScrollBarStyles instance';

  SLMDNoMoreTokensMessage = 'No more tokens left';

  SInvalidThemeFileName = 'Invalid theme file name [%s]';
  SUnknownTheme = 'Unknown theme [%s]';
  SUnknownThemePart = 'Unknown theme part [%d]';
  SUnknownThemeColorScheme = 'Unknown theme color scheme [%s]';
  SUnknownThemeBool = 'Unknown system metric boolean [%d]';
  SUnknownThemeColor = 'Unknown system metric color [%d]';
  SUnknownThemeFont = 'Unknown system metric font [%d]';
  SUnknownThemeInt = 'Unknown system metric int [%d]';
  SUnknownThemeSize = 'Unknown system metric size [%d]';
  SUnknownThemeString = 'Unknown system metric string [%d]';
  SInvalidRefCount = 'Invalid RefCount value in [%s]';

  SWinXPThemeNoDisplayName = 'No display name for this theme';
  SWinXPThemeInvalidParameter = 'Invalid function parameter';
  SWinXPThemeNoDocProp = 'Documenation property [%s] is undefined';
  SWinXPThemeNoSchemeSection = 'Cannot find an appropriate scheme section';
  SWinXPThemeNoMetricsProp = 'System metrics property [%d] is undefined';
  SWinXPThemeNoSchemeProp = 'Theme property [%d] is undefined';
  SWinXPThemeTextMetricFailed = 'Failed to get text metric';

  SUnkOSError = 'A call to an OS function failed';
  SOSError = 'System Error.  Code: %d.'#13#10'%s';

  STExOutOfBounds = 'ElTree item index out of bounds.';
  STexInvItem = 'ElTree item not specified';
  STexRecursiveMove = 'Can''t move or copy Item to one of its subitems.';

  SInvalidPropertyValue = 'Invalid property value';

  SLMDCaption = 'Image List Editor';

  SLMDQuestion = 'Choose a way of processing of this picture';

  SLMDTipOfTheDay = 'Tip of the Day';
  SLMDDidYouKnow = '  Did you know...';
  SLMDShowTipsAtStartup = 'Show tips at startup';
  SLMDNextTip = '&Next Tip';
  SLMDClose = '&Close';

  SLMDStyleInstanceNotAssigned  = 'Style instance not initialized for %s';

const
  LMDElHideSelectTextColor = clBtnShadow;
implementation
end.
