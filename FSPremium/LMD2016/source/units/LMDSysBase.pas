unit LMDSysBase;
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

LMDSysBase unit (JH)
-----------------------
The LMDSysBase unit contains bases classes, general variables, types and functions
needed in LMD SysPack.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Sysutils, Classes, forms, windows, controls, messages, Graphics, ExtCtrls,
  LMDSysConst, LMDCustomComponent, LMDTypes, LMDProcs;

  {$R LMDSysPack.res}

const
  LMDMinutesPerDay=1440;

type  // Win NT and better only
  TLMDSysProductType=(sptUnknown, sptWorkStation, sptServer, sptDomainController);

  TLMDSysProductSuite=(spsSmallBusiness, spsEnterprise, spsBackOffice, spsCommunications,
                       spsTerminal, spsSmallBusinessRestricted, spsEmbeddedNT, spsDataCenter,
                       spsSingleUserTS, spsPersonal, spsWebEdition, spsEmbeddedRestricted);
  TLMDSysProductSuites=set of TLMDSysProductSuite;

Type
  TLMDSysProperty=record
    Name:String;
    Description:String;
  end;

const
  sLMDSysProductType:array[TLMDSysProductType] of string=(sLMDSysNOTAVAILABLE, 'WorkStation',
                                                          'Server', 'Domain Controller');
type
  TLMDSysDirection=(sdAscending, sdDescending);

  {-------------------- TLMDSysComponent -------------------------------------}
  TLMDSysComponent = class(TLMDCustomComponent)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

const
  IID_ILMDSysContainer: TGUID = '{D8DECF0C-3DE0-4E44-AD38-F022380E2970}';
  IID_ILMDSysDescriptor: TGUID = '{059155C7-51D6-4EAF-8795-76F40E6AABD3}';
  IID_ILMDSysPublisher: TGUID = '{0E5B3D50-3B18-450A-BF9B-8595BE330FC8}';

type
  ILMDSysContainer = interface(IUnknown)
  ['{D8DECF0C-3DE0-4E44-AD38-F022380E2970}']
    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;
  end;

  TLMDSysInfoType =(itUnknown, itSystemInfoGroup, itDisplayGroup, itDisplayMode,
        itDisplayModes, itDisplayPlus, itDisplayWallpaper, itDisplayScreenSaver,
        itMouse, itDriveGroup, itFloppyDrive, itFixedDrive, itCDROMDrive,
        itPrinterGroup, itPrinter, itWindows, itKeyboard, itMemory, itProcessor,
        itPowerStatus, itTimeZone, itLocale, itUninstallGroup, itUninstallItem,
        itFontGroup, itFont, itMultimediaGroup, itJoystickGroup, itJoystick,
        itMidiOutAudioGroup, itMIDIiOutAudio, itMidiInAudioGroup, itMIDIiInAudio,
        itwaveOutAudioGroup, itwaveOutAudio, itwaveInAudioGroup, itwaveInAudio,
        itDauxAudioGroup, itDauxAudio, itMixerGroup, itMixer,
        itFileActionGroup, itFileAction, itFileAssocGroup, itFileAssoc,
        itInetAdvPropGroup, itInetAdvProp, itInetZoneGroup, itInetZone,
        itTempInternetFiles, itInternet, itModemGroup, itModem,
        itTCPIP, itIPX, itNetBEUI, itNetwork, itNetworkCard, itNetworkCardGroup,
        itDriver, itService, itServiceGroup);

  ILMDSysDescriptor = interface(IUnknown)
  ['{059155C7-51D6-4EAF-8795-76F40E6AABD3}']
    function GetElementType : TLMDSysInfoType;
    function GetElementTitle : string;
    function GetElementDescription : string;
  end;

  TLMDSysPropertyType = (ptUnknown);
  ILMDSysPublisher = interface(IUnknown)
  ['{0E5B3D50-3B18-450A-BF9B-8595BE330FC8}']
    function GetPropertiesCount : integer;
    function GetPropAvailability(index : integer) : boolean;
    function GetPropType(index : integer) : TLMDSysPropertyType;
    function GetPropValue(index : integer) : variant;
    function GetPropText(index : integer) : string;
    function GetPropTitle(index : integer) : string;
    function GetPropDescription(index : integer) : string;
  end;

function LMDSysUnixTimeToDateTime(aTime: DWORD):TDateTime;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  dialogs;
  {$I C2.INC}
{$ENDIF}

// convert Unix t_time to TDateTime
{------------------------------------------------------------------------------}
function LMDSysUnixTimeToDateTime(aTime: DWORD):TDateTime;
var
  SysTime, tmpSysTime: TSystemTime;
  FileTime, LocalTime: TFileTime;
  tmp: TDateTime;
begin
  tmp:=EncodeDate(1970, 1, 1)+(aTime div 86400);
  tmp:=tmp+((aTime mod 86400)/86400);
  // following code required to consider time bias, works in Win9X as well
  DateTimeToSystemTime(tmp, tmpSysTime);
  SystemTimeToFileTime(tmpSysTime, FileTime);
  FileTimeToLocalFileTime(FileTime, LocalTime);
  FileTimeToSystemTime(LocalTime, SysTime);
  result := SystemTimeToDateTime(SysTime);
end;

{ TLMDSysComponent }
{------------------------------------------------------------------------------}
function TLMDSysComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_SYS;
end;

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C1.INC}
  {$ENDIF}
end.
