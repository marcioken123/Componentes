unit LMD_RegSys;
{$I LMDCmps.inc}

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

LMD_RegSys unit (RM)
-------------------
Registration unit for LMD SysPack

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, Controls,

  pLMDComAboutDlg, pLMDCommon,

  //components
  LMDSysSystemInfo,
  LMDSysLog,
  LMDSysMouse,
  LMDSysKeyboard,
  LMDSysDrive,
  LMDSysDisplay,
  LMDSysLocale,
  LMDSysMemory,
  LMDSysPowerStatus,
  LMDSysTimeZone,
  LMDSysWindows,
  LMDSysPrinters,
  LMDSysProcessor,
  LMDSysProcessorObject,
  LMDSysUninstall,
  LMDSysFonts,
  LMDSysMultimedia,
  LMDSysFileAssoc,
  LMDSysInternet,
  LMDSysModem,
  LMDSysNetwork,

  // 3.0
  LMDSysNetworkEnumerator,
  LMDSysNetTreeView,
  LMDSysEventLog,
  LMDSysEventListView,

  //objects
  LMDSysDisplayObject,
  LMDSysPrinterInfo,
  pLMDSys_PE,
  pLMDSys_CE,

  LMDSysInfoTreeView,
  LMDSysInfoListView;

procedure Register;

implementation
uses
  // base units
  LMDSysBase,
  LMDSysBaseComponent,

  pLMDCst,
  pLMDOIEnh,
  LMDSysMouseObject,
  LMDSysTimeZoneObject,
  LMDSysWindowsObject,
  LMDSysKeyboardObject,
  LMDSysLocaleObject ,
  LMDSysMemoryObject,
  LMDSysPowerStatusObject,
  LMDSysModemInfo,
  LMDSysInternetObject,
  LMDSysMultimediaObject,
  LMDSysFontInfo,
  LMDSysDriveObject,
  Sysutils;

{------------------------------------------------------------------------------}
procedure Register;
begin
  // Connect TLMDSysBaseComponent with TWinControl, so that it no longer appears
  // on CLX palette.
  GroupDescendentsWith(TLMDSysComponent, TWinControl);

  // nonvisual System components
  RegisterComponents('LMD Sys Info', [TLMDSysSystemInfo,
                                      TLMDSysLog,
                                      TLMDSysMouse,
                                      TLMDSysKeyboard,
                                      TLMDSysDrive,
                                      TLMDSysDrives,
                                      TLMDSysDisplay,
                                      TLMDSysLocale,
                                      TLMDSysMemory,
                                      TLMDSysPowerStatus,
                                      TLMDSysTimeZone,
                                      TLMDSysWindows,
                                      TLMDSysPrinters,
                                      TLMDSysProcessor,
                                      TLMDSysUninstall,
                                      TLMDSysFonts,
                                      TLMDSysMultimedia,
                                      TLMDSysFileAssoc,
                                      TLMDSysInternet,
                                      TLMDSysNetwork,
                                      TLMDSysModem,
                                      // new in 2.0
                                      TLMDSysNetworkEnumerator,
                                      TLMDSysInfoTreeView,
                                      TLMDSysNetTreeView,
                                      TLMDSysInfoListView,
                                      TLMDSysEventLog,
                                      TLMDSysEventListView
                                      ]);

  // property and component editors
  // ==============================

  // Component Editors
  RegisterComponentEditor(TLMDSysBaseComponent, TLMDSystemComponentEditor);
  RegisterComponentEditor(TLMDSysNetworkEnumerator, TLMDSysNetComponentEditor);

  // get current global settings
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      // extended set editors, including dialog for simple flag settings
      RegisterPropertyEditor(TypeInfo(TLMDSysMouseDisplayInfos), TLMDSysMouseObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysTimeZoneDisplayInfos), TLMDSysTimeZoneObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysProcessorDisplayInfos), TLMDSysProcessorObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysPrinterDisplayInfos), TLMDSysPrinters, '', TLMDSysSetProperty);

      RegisterPropertyEditor(TypeInfo(TLMDSysPowerStatusDisplayInfos), TLMDSysPowerStatusObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysModemDisplayInfos), nil, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysMemoryDisplayInfos), TLMDSysMemoryObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysLocaleCurrencyInfos), (TLMDSysLocaleObject), '', TLMDSysSetProperty);

      RegisterPropertyEditor(TypeInfo(TLMDSysLocaleDateTimeInfos), (TLMDSysLocaleObject), '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysLocaleNumberInfos), (TLMDSysLocaleObject), '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysKeyboardDisplayInfos), TLMDSysKeyboardObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysInternetDisplayInfos), TLMDSysInternetObject, '', TLMDSysSetProperty);

      RegisterPropertyEditor(TypeInfo(TLMDSysPrinterDisplayInfos), nil, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysEventDlgOptions), TLMDSysEventLog, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysDisplayDisplayInfos), TLMDSysDisplayObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysWindowsDisplayInfos), TLMDSysWindowsObject, '', TLMDSysSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysSystemInfoDisplayInfos), TLMDSysSystemInfo, '', TLMDSysSetProperty);

      // usual Set editors
      RegisterPropertyEditor(TypeInfo(TLMDBatteryFlags), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysNetUsages), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDjoyCaps), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDmidiOutSupports), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDwaveOutSupports), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDmidiOutSupports), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDMIDIChannels), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDwaveFormats), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TtmFlags), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysFileSystemOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysProductSuites), nil, '', TLMDSetProperty);
   end;

end;

end.
