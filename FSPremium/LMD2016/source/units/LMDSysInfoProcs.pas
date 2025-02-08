unit LMDSysInfoProcs;
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

LMDSysInfoProcs unit (RM)
-------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes,
  LMDSysBase;

procedure LMDSysSystemFolders(aList:TStrings);

implementation
uses
  ShlObj, ActiveX, ShellApi,
  LMDSysConst, LMDShUtils;

const
  sLMDSysFolder:array[TLMDSystemFolder] of string=(
        sLMDSysFolderDesktop, sLMDSysFolderMyComputer, sLMDSysFolderPrograms, sLMDSysFolderControlPanel,
        sLMDSysFolderPrinters,sLMDSysFolderPersonal,sLMDSysFolderFavorites,
        sLMDSysFolderStartup,sLMDSysFolderRecent, sLMDSysFolderSendto,
        sLMDSysFolderRecycleBin,sLMDSysFolderStartMenu, sLMDSysFolderDesktopDirectory,
        sLMDSysFolderNetwork, sLMDSysFolderNetworkNeighborhood,sLMDSysFolderInternet,
        sLMDSysFolderFonts, sLMDSysFolderTemplates,sLMDSysFolderCommonStartMenu,
        sLMDSysFolderCommonPrograms, sLMDSysFolderCommonStartup,sLMDSysFolderCommonDesktopDirectory,
        sLMDSysFolderAppData, sLMDSysFolderPrintHood,sLMDSysFolderAltStartup,
        sLMDSysFolderCommonAltstartup, sLMDSysFolderCommonFavorites,sLMDSysFolderInternetCache,
        sLMDSysFolderCookies, sLMDSysFolderHistory,
        sLMDSysFolderMyVideo, sLMDSysFolderCommonVideo,
        sLMDSysFolderMyPictures, sLMDSysFolderCommonPictures, sLMDSysFolderMyMusic,
        sLMDSysFolderCommonMusic, sLMDSysFolderMyDocuments, sLMDSysFolderAdminTools,
        sLMDSysFolderCommonAdminTools, sLMDSysFolderBurnArea, sLMDSysFolderProfile,
        sLMDSysFolderProfiles, sLMDSysFolderProgramFiles, sLMDSysFolderCommonProgramFiles,
        sLMDSysFolderWindows, sLMDSysFolderSystem, '');

{------------------------------------------------------------------------------}
procedure LMDSysSystemFolders(aList:TStrings);
var
  i:TLMDRootFolder;
begin
  if aList=nil then exit;
  for i:=Low(TLMDRootFolder) to High(TLMDRootFolder) do
    aList.Add(sLMDSysFolder[TLMDRootFolder(i)]+'='+LMDGetSpecialFolderPath(TLMDRootFolder(i)));
end;

end.
